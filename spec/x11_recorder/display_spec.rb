require File.expand_path("../../spec_helper", __FILE__)

module X11Recorder
  describe Display do
    let(:mock_process) { double(ChildProcess, :start => nil, :stop => nil, :io => double('io').as_null_object) }

    it "can start recorder with default mp4 options" do
      display = ENV['DISPLAY'] || ':1'
      ChildProcess.should_receive(:build).with(
        'ffmpeg',
        '-an',
        '-y',
        '-f', 'x11grab',
        '-r', '5',
        '-s', '1024x768',
        '-i', display,
        '-vcodec', 'mpeg4',
        './test.mp4'
      ).and_return(mock_process)
      mock_process.should_receive(:start)
      mock_process.should_receive(:stop)

      recorder = X11Recorder::Display.new
      recorder.start
      recorder.stop
    end

    it "can start recorder with non-default mp4 options" do
      ChildProcess.should_receive(:build).with(
        'ffmpeg',
        '-an',
        '-y',
        '-f', 'x11grab',
        '-r', '6',
        '-s', '768x768',
        '-i', ':42',
        '-vcodec', 'v8',
        './test.webm'
      ).and_return(mock_process)
      mock_process.should_receive(:start)
      mock_process.should_receive(:stop)

      recorder = X11Recorder::Display.new(
        :filename => './test.webm',
        :codec => 'v8',
        :display => ':42',
        :frame_rate => '6',
        :frame_size => '768x768'
      )
      recorder.start
      recorder.stop
    end

  end
end
