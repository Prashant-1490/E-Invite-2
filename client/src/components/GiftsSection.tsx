import { useQuery } from "@tanstack/react-query";
import { type Gift } from "@shared/schema";
import { useLanguage } from "@/lib/i18n";

import { LoadingSkeleton } from "@/components/ui/loading";
import React, { useState, useCallback } from "react";
import { Carousel, CarouselContent, CarouselItem, CarouselPrevious, CarouselNext } from "@/components/ui/carousel";

export function GiftsSection() {
  const { language, t } = useLanguage();
  const { data: gifts, isLoading } = useQuery<Gift[]>({
    queryKey: ["/api/gifts"],
  });
  const [showAllGifts, setShowAllGifts] = useState(false);
  const [current, setCurrent] = useState(1);
  const [api, setApi] = useState<any>(null);

  // Split gifts into chunks of 5 for carousel
  const giftChunks = React.useMemo(() => {
    if (!gifts) return [];
    const chunks = [];
    for (let i = 0; i < gifts.length; i += 5) {
      chunks.push(gifts.slice(i, i + 5));
    }
    return chunks;
  }, [gifts]);

  React.useEffect(() => {
    if (!api) return;
    api.on("select", () => {
      setCurrent(api.selectedScrollSnap() + 1);
    });
  }, [api]);

  if (isLoading) {
    return (
      <section className="py-16 bg-background">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-4xl font-bold text-primary mb-4 font-serif gujarati-text">{t("gifts")}</h2>
            <div className="w-24 h-1 bg-gold mx-auto mt-4 rounded-full"></div>
          </div>
          <div className="grid grid-cols-5 gap-4 max-w-7xl mx-auto">
            {[...Array(5)].map((_, i) => (
              <LoadingSkeleton key={i} className="h-32 w-full" />
            ))}
          </div>
        </div>
      </section>
    );
  }

  return (
    <section className="py-16 bg-background">
      <div className="container mx-auto px-4">
        <div className="text-center mb-12">
          <h2 className="text-4xl font-bold text-primary mb-4 font-serif gujarati-text">
            {t("gifts")} {gifts?.length || 0}
          </h2>
          <div className="w-24 h-1 bg-gold mx-auto mt-4 rounded-full"></div>
          <p className="text-sm text-muted-foreground mt-4 italic">
            If I get married, I want to be very married
          </p>
        </div>

        {!showAllGifts ? (
          <>
            {/* Carousel View */}
            <Carousel
              setApi={setApi}
              className="max-w-7xl mx-auto"
              opts={{
                align: "start",
                loop: true,
              }}
            >
              <CarouselContent>
                {giftChunks.map((chunk, chunkIndex) => (
                  <CarouselItem key={chunkIndex}>
                    <div className="grid grid-cols-5 gap-4">
                      {chunk.map((gift) => (
                        <div
                          key={gift.id}
                          className="bg-card rounded-lg shadow-md border border-gold/30 p-4 hover:shadow-lg transition-shadow text-center"
                          data-testid={`gift-${gift.id}`}
                        >
                          <div className="mb-3">
                            <div className="w-10 h-10 bg-primary rounded-full flex items-center justify-center text-primary-foreground mx-auto mb-2">
                              <i className={`fas fa-${gift.giftIcon} text-sm`}></i>
                            </div>
                            <h5 className="font-semibold text-foreground text-xs gujarati-text mb-1">
                              {language === "gujarati" ? gift.donorNameGujarati : (gift.donorNameEnglish || gift.donorNameGujarati)}
                            </h5>
                            {(gift.organizationGujarati || gift.organizationEnglish) && (
                              <p className="text-xs text-muted-foreground mb-1">
                                {language === "gujarati" ? gift.organizationGujarati : (gift.organizationEnglish || gift.organizationGujarati)}
                              </p>
                            )}
                          </div>
                          <p className="text-xs text-secondary font-medium gujarati-text mb-2">
                            {language === "gujarati" ? gift.giftDescriptionGujarati : (gift.giftDescriptionEnglish || gift.giftDescriptionGujarati)}
                          </p>
                          {gift.amount && (
                            <p className="text-sm font-bold text-green-600">₹{gift.amount}</p>
                          )}
                        </div>
                      ))}
                    </div>
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious />
              <CarouselNext />
            </Carousel>

            {/* Navigation Dots */}
            <div className="flex justify-center mt-6 gap-2">
              {giftChunks.map((_, index) => (
                <button
                  key={index}
                  onClick={() => api?.scrollTo(index)}
                  className={`w-3 h-3 rounded-full transition-all ${
                    current === index + 1 ? "bg-primary" : "bg-gray-300"
                  }`}
                />
              ))}
            </div>

            {/* Show All Button */}
            <div className="text-center mt-8">
              <button
                onClick={() => setShowAllGifts(true)}
                className="bg-red-500 text-white px-6 py-2 rounded-lg hover:bg-red-600 transition-colors font-medium"
              >
                Show All Gift List
              </button>
            </div>
          </>
        ) : (
          <>
            {/* Grid View - Show All */}
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4 max-w-7xl mx-auto">
              {gifts?.map((gift) => (
                <div
                  key={gift.id}
                  className="bg-card rounded-lg shadow-md border border-gold/30 p-4 hover:shadow-lg transition-shadow text-center"
                  data-testid={`gift-${gift.id}`}
                >
                  <div className="mb-3">
                    <div className="w-10 h-10 bg-primary rounded-full flex items-center justify-center text-primary-foreground mx-auto mb-2">
                      <i className={`fas fa-${gift.giftIcon} text-sm`}></i>
                    </div>
                    <h5 className="font-semibold text-foreground text-xs gujarati-text mb-1">
                      {language === "gujarati" ? gift.donorNameGujarati : (gift.donorNameEnglish || gift.donorNameGujarati)}
                    </h5>
                    {(gift.organizationGujarati || gift.organizationEnglish) && (
                      <p className="text-xs text-muted-foreground mb-1">
                        {language === "gujarati" ? gift.organizationGujarati : (gift.organizationEnglish || gift.organizationGujarati)}
                      </p>
                    )}
                  </div>
                  <p className="text-xs text-secondary font-medium gujarati-text mb-2">
                    {language === "gujarati" ? gift.giftDescriptionGujarati : (gift.giftDescriptionEnglish || gift.giftDescriptionGujarati)}
                  </p>
                  {gift.amount && (
                    <p className="text-sm font-bold text-green-600">₹{gift.amount}</p>
                  )}
                </div>
              ))}
            </div>

            {/* Back to Carousel Button */}
            <div className="text-center mt-8">
              <button
                onClick={() => setShowAllGifts(false)}
                className="bg-primary text-white px-6 py-2 rounded-lg hover:bg-primary/90 transition-colors font-medium"
              >
                Back to Carousel View
              </button>
            </div>
          </>
        )}
      </div>
    </section>
  );
}
