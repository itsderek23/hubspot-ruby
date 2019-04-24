class Hubspot::PagedModifiedCollection < Hubspot::PagedCollection
  attr_accessor :time_offset

  def initialize(opts = {}, &block)
    @time_offset_param = opts.delete(:time_offset_param) || "time_offset"
    @time_offset = opts.delete(:time_offset)

    super(opts, &block)
  end

  def time_offset_to_time
    Time.zone.at(time_offset/1000)
  end

  def next_time_offset
    @next_time_offset
  end

  def next_page?
    @has_more
  end

  def next_page
    @time_offset = next_time_offset
    super
  end

protected

  def fetch
    @resources, @next_offset, @next_time_offset, @has_more = @fetch_proc.call(@options, @offset, @time_offset, @limit)
  end
end
