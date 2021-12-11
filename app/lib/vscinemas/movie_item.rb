# frozen_string_literal: true

module VSCinemas
  class MovieItem
    # @since 0.1.0
    attr_reader :element

    # @param element [Nokogiri::XML::Element]
    #
    # @since 0.1.0
    def initialize(element)
      @element = element
      @info_element = element.css('.infoArea')
      @tag_elements = element.css('.iconArea .theaterMark')
    end

    # ID
    #
    # @return [Number]
    #
    # @since 0.1.0
    def id
      @id = URI.decode_www_form(detail_url.query).to_h.fetch('id', nil)&.to_i
    end

    # Title
    #
    # @return [String]
    #
    # @since 0.1.0
    def title
      @title ||= @info_element.css('h2').text&.strip
    end

    # English Title
    #
    # @return [String]
    #
    # @since 0.1.0
    def title_en
      @title_en ||= @info_element.css('h3').text&.strip
    end

    # Date
    #
    # @return [Date]
    #
    # @since 0.1.0
    def date
      @date ||= Date.parse(@info_element.css('time').to_s)
    rescue ArgumentError
      nil
    end

    # Detail URL
    #
    # @return [URI]
    #
    # @since 0.1.0
    def detail_url
      @detail_url ||= URI.join(ENDPOINT, PATH, @element.css('h2 a').attr('href').text)
    end

    # Figure URI
    #
    # @return [URI]
    #
    # @since 0.1.0
    def figure
      @figure ||= URI.join(ENDPOINT, PATH, @element.css('figure img').attr('src').text)
    end

    # @return [Hash]
    #
    # @since 0.1.0
    def to_h
      {
        id: id,
        title: title,
        title_en: title_en,
        date: date,
        detail_url: detail_url,
        figure: figure
      }
    end

    # Inspect
    #
    # @return [String]
    #
    # @since 0.1.0
    def inspect
      "#<#{self.class.name} title=#{title} date=#{date}>"
    end
  end
end
