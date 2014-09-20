
module X11Recorder
  class Display

    DEFAULT_OPTIONS = {
      :filename => './test.mp4',
      :codec => 'mpeg4',
      :display => ENV['DISPLAY'],
      :frame_rate => '5',
      :frame_size => '1024x768'
    }

    def initialize(opts = {})
      @options = DEFAULT_OPTIONS.dup.merge(opts)
    end

    def start
      @recorder = create_process
      @recorder.start
    end

    def stop
      @recorder && @recorder.stop
      @recorder = nil
    end

    private

    def create_process
      @output = @options[:filename]

      process = ChildProcess.build(
        'ffmpeg',
        '-an',
        '-y',
        '-f', 'x11grab',
        '-r', @options[:frame_rate],
        '-s', @options[:frame_size],
        '-i', @options[:display],
        '-vcodec', @options[:codec],
        @options[:filename]
      )

      process.io.stdout = process.io.stderr = File.open('/dev/null', 'w')
      process
    end
  end
end
