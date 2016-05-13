require File.expand_path(File.dirname(__FILE__) + '/../triangle')

describe Triangle do

  # describe "型実験" do
  #   it { expect("a".is_a?(String)).to be_truthy }
  #   it { expect("a".is_a?(Numeric)).to be_falsy }
  #
  #   it { expect("1".is_a?(String)).to be_truthy }
  #   it { expect("1".is_a?(Numeric)).to be_falsy }
  #
  #   it { expect("a".is_a?(String)).to be_truthy }
  #
  #
  #   d = "a".to_d
  #   p d
  #   d = BigDecimal("a")
  #   p d
  #   d = "k".to_d
  #   p d
  #   d = "金".to_d
  #   p d
  #   d = BigDecimal.new("金")
  #   p d
  #   f = Float("1.2")
  #   p f
  #   # f = Float("金")
  #   # p f
  #   # it { expect("a".to_d).to be_true }
  #
  #   r = Rational("1.1")
  #   p r
  #   r = Rational(".1")
  #   p r
  #   r = Rational("-1.1")
  #   p r
  #
  # end
  #
  # describe "split実験" do
  #
  #   it { expect("1,".split(",")).to eq ["1"] }
  #
  #   it { expect(",1".split(",")).to eq ["", "1"] }
  #   it { expect(",1".split(",").reject(&:empty?)).to eq ["1"] }
  #
  #   testdata = {
  #       ["1, ", " -1", " ,2"] =>  [1, -1, 2],
  #       ["1,-1,2"] => [1, -1, 2],
  #       ["1,-1,", " 2"] => [1, -1, 2],
  #       ["1", "2", "3"] => [1, 2, 3],
  #   }
  #
  #   testdata.each do |q, ans|
  #     it { expect(q.inject([]) { |s, a| s.concat(a.split(/\s*,\s*/).reject(&:empty?).map(&:to_i)) }).to eq ans }
  #   end
  #   testdata.each do |q, ans|
  #     puts "q -> #{q}"
  #     puts "q.join(" ") -> #{q.join(" ")}"
  #     puts "q.join(" ").split(/[\s,]+/) -> #{q.join(" ").split(/[\s,]+/)}"
  #     # it { expect(q.join(" ").split(/\s*,\s*/).reject(&:empty?).map(&:to_i)).to eq ans }
  #     it { expect(q.join(" ").split(/[\s,]+/).reject(&:empty?).map(&:to_i)).to eq ans }
  #   end
  # end

  describe "Triangle.argv_to_num_array のテスト" do
    describe "正常系" do
      test_data = {
          ["2,", "0,", "-4"] =>  [2, 0, -4],
          ["2,0,-4"] => [2, 0, -4],
          ["2,0,", "-4"] => [2, 0, -4],
          ["2", "0", "-4"] => [2, 0, -4],

          ["2.5,", ".35,", "-4.2"] => [2.5, 0.35, -4.2],
          ["2.5,.35,-4.2"]         => [2.5, 0.35, -4.2],
          ["2.5,.35,", "-4.2"]     => [2.5, 0.35, -4.2],
          ["2.5", ".35", "-4.2"]   => [2.5, 0.35, -4.2],
      }
      test_data.each do |q, ans|
        it { expect(Triangle.argv_to_num_array(q)).to eq ans }
      end
    end

    describe "異常系" do
      invalid_data = {
          [", ,"] => [],
      }
      invalid_data.each do |q, ans|
        it { expect(Triangle.argv_to_num_array(q)).to eq ans }
      end
    end

    describe "異常系" do
      invalid_data = {
          ["a,", "d,", "e"] => false,
      }
      invalid_data.each do |q, ans|
        it { expect { Triangle.argv_to_num_array(q) }.to raise_error(ArgumentError) }
      end
    end

  end

  describe "Triangle.triangle_type のテスト" do
    # triangle_type引数は数値型前提とした。それ以外が来たときは振る舞い不定のため、テスト対象としない
    # describe "引数 型異常" do
    #   specify { expect { Triangle.triangle_type(nil, nil, nil) }.to raise_error }
    #   specify { expect { Triangle.triangle_type(nil, 2, 3) }.to raise_error  }
    #
    #   specify { expect { Triangle.triangle_type("b,", "c,", "a,") }.to raise_error }
    #   specify { expect { Triangle.triangle_type("a,", "2,", "3") }.to raise_error }
    # end

    describe "負数・0" do
      specify { expect(Triangle.triangle_type(-1, -1, -1)).to eq 0  }
      specify { expect(Triangle.triangle_type(-1, 4, 4)).to eq 0 }

      specify { expect(Triangle.triangle_type(1, 1, 0)).to eq 0  }
      specify { expect(Triangle.triangle_type(0, 0, 0)).to eq 0  }
    end

    describe "三角形にならない" do
      specify { expect(Triangle.triangle_type(1, 2, 3)).to eq 0 }

      specify { expect(Triangle.triangle_type(1.5, 1.7, 3.2)).to eq 0 }

      specify { expect(Triangle.triangle_type(20, 3, 2)).to eq 0 }
    end

    describe "正三角形" do
      specify { expect(Triangle.triangle_type(1, 1, 1)).to eq 3 }
      specify { expect(Triangle.triangle_type(3.1, 3.1, 3.1)).to eq 3 }
      specify { expect(Triangle.triangle_type(10, 10, 10)).to eq 3 }
    end

    describe "二等辺三角形" do
      describe "長辺1 短辺2" do
        specify { expect(Triangle.triangle_type(2, 2, 3)).to eq 2}
        specify { expect(Triangle.triangle_type(3.1, 3.09, 3.09)).to eq 2 }
        specify { expect(Triangle.triangle_type(10, 9, 9)).to eq 2}
      end
      describe "長辺2 短辺1" do
        specify { expect(Triangle.triangle_type(1, 2, 2)).to eq 2 }
        specify { expect(Triangle.triangle_type(3.1, 3.11, 3.11)).to eq 2 }
        specify { expect(Triangle.triangle_type(10, 10, 9)).to eq 2 }
      end
    end

    describe "ただの三角形（不等辺三角形）" do
      specify { expect(Triangle.triangle_type(2, 3, 4)).to eq 1 }
      specify { expect(Triangle.triangle_type(3.1, 3.11, 3.111)).to eq 1 }
      specify { expect(Triangle.triangle_type(11, 10, 9)).to eq 1 }
    end

  end

  describe "Triangle.triangle_type_from_arrayのテスト" do
    describe "提示されている問題" do
      test_data = {
          ["2,", "3,", "4"] => 1,
          ["2,", "2,", "1"] => 2,
          ["1,", "1,", "1"] => 3,
          ["1,", "2,", "3"] => 0,
      }
      test_data.each do |q, ans|
        it { expect(Triangle.triangle_type_from_array(q)).to eq ans }
      end
    end
  end

end
