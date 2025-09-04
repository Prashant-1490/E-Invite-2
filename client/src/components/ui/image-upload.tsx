import React, { useCallback, useState } from 'react';
import { useDropzone } from 'react-dropzone';
import { Upload, X, Image as ImageIcon } from 'lucide-react';
import { Button } from './button';
import { cn } from '@/lib/utils';

interface ImageUploadProps {
  value?: string;
  onChange: (value: string) => void;
  disabled?: boolean;
  className?: string;
}

export function ImageUpload({
  value,
  onChange,
  disabled = false,
  className
}: ImageUploadProps) {
  const [uploading, setUploading] = useState(false);

  const uploadImage = async (file: File) => {
    setUploading(true);
    try {
      const formData = new FormData();
      formData.append('image', file);
      
      const response = await fetch('/api/upload', {
        method: 'POST',
        body: formData,
      });

      if (!response.ok) {
        throw new Error('Upload failed');
      }

      const data = await response.json();
      onChange(data.imageUrl);
    } catch (error) {
      console.error('Upload error:', error);
      alert('Failed to upload image. Please try again.');
    } finally {
      setUploading(false);
    }
  };

  const onDrop = useCallback((acceptedFiles: File[]) => {
    if (acceptedFiles.length > 0) {
      uploadImage(acceptedFiles[0]);
    }
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      'image/*': ['.jpeg', '.jpg', '.png', '.gif', '.webp']
    },
    maxFiles: 1,
    disabled: disabled || uploading
  });

  const removeImage = () => {
    onChange('');
  };

  return (
    <div className={cn("space-y-4", className)}>
      {value ? (
        <div className="relative">
          <div className="relative aspect-video w-full overflow-hidden rounded-lg border border-border">
            <img
              src={value}
              alt="Upload preview"
              className="h-full w-full object-cover"
            />
          </div>
          <Button
            type="button"
            onClick={removeImage}
            variant="destructive"
            size="sm"
            className="absolute -right-2 -top-2"
            disabled={disabled || uploading}
          >
            <X className="h-4 w-4" />
          </Button>
        </div>
      ) : (
        <div
          {...getRootProps()}
          className={cn(
            "relative cursor-pointer rounded-lg border-2 border-dashed border-border p-6 text-center transition-colors",
            isDragActive && "border-primary bg-primary/5",
            (disabled || uploading) && "cursor-not-allowed opacity-50"
          )}
        >
          <input {...getInputProps()} />
          <div className="mx-auto flex max-w-[420px] flex-col items-center justify-center text-center">
            {uploading ? (
              <>
                <Upload className="mx-auto h-10 w-10 animate-pulse text-muted-foreground" />
                <p className="mt-2 text-sm text-muted-foreground">
                  Uploading image...
                </p>
              </>
            ) : (
              <>
                <ImageIcon className="mx-auto h-10 w-10 text-muted-foreground" />
                <p className="mt-2 text-sm font-medium">
                  {isDragActive
                    ? "Drop the image here"
                    : "Drag & drop an image here, or click to select"}
                </p>
                <p className="text-xs text-muted-foreground">
                  PNG, JPG, GIF up to 10MB
                </p>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
