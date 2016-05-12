require File.expand_path(File.dirname(__FILE__) + '/../triangle')

describe Triangle do

  describe "split実験", pending => true do

    it { expect("1,".split(",")).to eq ["1"] }

    it { expect(",1".split(",")).to eq ["", "1"] }
    it { expect(",1".split(",").reject(&:empty?)).to eq ["1"] }

    testdata = {
        ["1, ", " -1", " ,2"] =>  [1, -1, 2],
        ["1,-1,2"] => [1, -1, 2],
        ["1,-1,", " 2"] => [1, -1, 2],
        ["1", "2", "3"] => [1, 2, 3],
    }

    testdata.each do |q, ans|
      it { expect(q.inject([]) { |s, a| s.concat(a.split(/\s*,\s*/).reject(&:empty?).map(&:to_i)) }).to eq ans }
    end
    testdata.each do |q, ans|
      puts "q -> #{q}"
      puts "q.join(" ") -> #{q.join(" ")}"
      puts "q.join(" ").split(/[\s,]+/) -> #{q.join(" ").split(/[\s,]+/)}"
      # it { expect(q.join(" ").split(/\s*,\s*/).reject(&:empty?).map(&:to_i)).to eq ans }
      it { expect(q.join(" ").split(/[\s,]+/).reject(&:empty?).map(&:to_i)).to eq ans }
    end





  end

  describe "引数 型異常" do
    specify { expect(Triangle.triangle_type(nil, nil, nil)).to eq 0  }
    specify { expect(Triangle.triangle_type(nil,2,3)).to eq 0  }

    specify { expect(Triangle.triangle_type("b,", "c,", "a,")).to eq 0 }    # stringはto_iで0に変換されるので
    specify { expect(Triangle.triangle_type("a,", "2,", "3")).to eq 0  }
  end

  describe "小数・負数・0" do
    specify { expect(Triangle.triangle_type("1.5,", "1.7,", "2")).to eq 0 }      # 小数はto_iで0に変換されるので

    specify { expect(Triangle.triangle_type(-1, -1, -1)).to eq 0  }
    specify { expect(Triangle.triangle_type(-1, 4, 4)).to eq 0 }

    specify { expect(Triangle.triangle_type(1, 1, 0)).to eq 0  }
    specify { expect(Triangle.triangle_type(0, 0, 0)).to eq 0  }
  end

  describe "三角形にならない" do
    specify { expect(Triangle.triangle_type("1,","2,","3")).to eq 0  }
    specify { expect(Triangle.triangle_type(1, 2, 3)).to eq 0 }

    specify { expect(Triangle.triangle_type(20, 3, 2)).to eq 0 }
  end

  describe "ただの三角形（不等辺三角形）" do
    specify { expect(Triangle.triangle_type(2, 3, 4)).to eq 1 }
    specify { expect(Triangle.triangle_type("11","10","9")).to eq 1 }
  end

  describe "二等辺三角形" do
    describe "長辺1 短辺2" do
      specify {expect(Triangle.triangle_type("2", "2", "3")).to eq 2}
      specify {expect(Triangle.triangle_type(10, 9, 9)).to eq 2}
    end
    describe "長辺2 短辺1" do
      specify {expect(Triangle.triangle_type(1, 2, 2)).to eq 2 }
      specify {expect(Triangle.triangle_type(10, 10, 9)).to eq 2 }
    end
  end

  describe "正三角形" do
    specify { expect(Triangle.triangle_type(1, 1, 1)).to eq 3 }
    specify { expect(Triangle.triangle_type("10", "10", "10")).to eq 3 }
    specify { expect(Triangle.triangle_type(3, 3, 3)).to eq 3 }
  end


end
