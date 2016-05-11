require File.expand_path(File.dirname(__FILE__) + '/../triangle')

describe Triangle do
  specify { expect(Triangle.is_valid(nil)).to eq -1 }
  specify { expect(Triangle.is_valid([1, 3])).to eq -1 }
  specify { expect(Triangle.is_valid([1, 3, 4, 5])).to eq -1 }

  specify { expect(Triangle.is_valid([1, 3, "a"])).to eq 0 }    # "a"はto_iで0に変換されるので
  specify { expect(Triangle.is_valid([1.5, 1.7, 2])).to eq 0 }  # 小数はto_iで0に変換されるので

  specify { expect(Triangle.is_valid([-1, 4, 4])).to eq 0 }


  specify { expect(Triangle.is_valid([1, 2, 3])).to eq 0 }
  specify { expect(Triangle.is_valid([3, 5, 8])).to eq 0 }


  specify { expect(Triangle.is_valid([2, 3, 4])).to eq 1 }

  specify { expect(Triangle.is_valid([4, 4, 1])).to eq 2 }
  specify { expect(Triangle.is_valid([2, 2, 3])).to eq 2 }
  specify { expect(Triangle.is_valid([1, 1, 1])).to eq 3 }

end