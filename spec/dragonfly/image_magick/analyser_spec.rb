require 'spec_helper'

describe Dragonfly::ImageMagick::Analyser do
  
  before(:each) do
    @image = Dragonfly::TempObject.new(SAMPLES_DIR.join('beach.png'))
    @analyser = Dragonfly::ImageMagick::Analyser.new
  end

  it "should return the width" do
    @analyser.width(@image).should == 280
  end

  it "should return the height" do
    @analyser.height(@image).should == 355
  end

  it "should return the aspect ratio" do
    @analyser.aspect_ratio(@image).should == (280.0/355.0)
  end

  it "should say if it's portrait" do
    @analyser.portrait?(@image).should be_true
  end

  it "should say if it's landscape" do
    @analyser.landscape?(@image).should be_false
  end

  it "should return the format" do
    @analyser.format(@image).should == :png
  end

  it "should say if it's an image" do
    @analyser.image?(@image).should == true
  end
  
  it "should say if it's not an image" do
    suppressing_stderr do
      @analyser.image?(Dragonfly::TempObject.new('blah')).should == false
    end
  end

  it "should work for images with spaces in the filename" do
    image = Dragonfly::TempObject.new(SAMPLES_DIR.join('white pixel.png'))
    @analyser.width(image).should == 1
  end
  
  it "should work (width) for images with capital letter extensions" do
    image = Dragonfly::TempObject.new(SAMPLES_DIR.join('DSC02119.JPG'))
    @analyser.width(image).should == 1
  end

  it "should work (width) for images with numbers in the format" do
    image = Dragonfly::TempObject.new(SAMPLES_DIR.join('a.jp2'))
    @analyser.width(image).should == 1
  end

end
