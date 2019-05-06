class TimeFormat
  FORMATS = {year: "%Y", month: "%m", day: "%d", hour: "%H", minute: "%M", second: "%S"}.freeze

  attr_reader :formats, :errors

  def initialize(time_string)
    @formats = []
    @errors = []
    @time_string = time_string

    check_formats
  end

  def result
    Time.now.strftime(@formats.join('-'))
  end

  private

  def check_formats
    @time_string.split(',').each do |format|
      if FORMATS[format.to_sym]
        @formats << FORMATS[format.to_sym]
      else
        @errors << format
      end
    end
  end
end