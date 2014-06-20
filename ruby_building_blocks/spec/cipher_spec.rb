require_relative './spec_helper'

describe "cipher" do 

  it "shifts letters by 1" do 
    str = "abcde"
    result = caesar_cipher(str,1)
    result.should == "bcdef"
  end

  it "wraps around z to a" do 
    str = "quiz"
    result = caesar_cipher(str,2)
    result.should == "swkb"
  end

  it "maintains case" do
    str = "teST"
    result = caesar_cipher(str, 10)
    result.should == "doCD"
  end

  it "does not change punctuation or spaces" do 
    str = "What a string!"
    result = caesar_cipher(str, 5)
    result.should == "Bmfy f xywnsl!"
  end

end