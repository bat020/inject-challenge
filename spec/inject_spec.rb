describe Array do

  context 'when injected with three arguments' do
    context 'and a block' do
      block = proc { |memo, obj| memo = memo + obj }
      it 'raises an argument error for []' do
        expect{[].inject(0, 1, :+, &block)}.to raise_error{ArgumentError}
      end
    end
    context 'but no block' do
      it 'raises an argument error for []' do
        expect{[].inject(0, 1, :+)}.to raise_error{ArgumentError}
      end
    end
  end

  context 'when injected with a block' do

    context 'that does +' do
      block = proc { |memo, obj| memo = memo + obj }
      context 'with no arguments' do
        it 'returns nil for []' do
          expect([].inject(&block)).to eq nil
        end
        it 'returns :dummy for [:dummy]' do
          expect([:dummy].inject(&block)).to eq :dummy
        end
        it 'returns 10 for [4,3,2,1]' do
          expect([4,3,2,1].inject(&block)).to eq 10
        end
        it "returns 'dog' for ['d','o','g']" do
          expect(['d','o','g'].inject(&block)).to eq 'dog'
        end
      end
      context 'with one argument 5' do
        it 'returns 5 for []' do
          expect([].inject(5, &block)).to eq 5
        end
        it 'returns 104 for [99]' do
          expect([99].inject(5, &block)).to eq 104
        end
        it 'returns 15 for [4,3,2,1]' do
          expect([4,3,2,1].inject(5, &block)).to eq 15
        end
        it "raises a type error for ['d','o','g']" do
          expect{['d','o','g'].inject(5, &block)}.to raise_error{TypeError}
        end
      end
      context 'with two arguments 5, :*' do
        it 'returns 5 for []' do
          expect([].inject(5, :*, &block)).to eq 5
        end
        it 'returns 495 for [99]' do
          expect([99].inject(5, :*, &block)).to eq 495
        end
        it 'returns 120 for [4,3,2,1]' do
          expect([4,3,2,1].inject(5, :*, &block)).to eq 120
        end
        it "raises a type error for ['d','o','g']" do
          expect{['d','o','g'].inject(5, :*, &block)}.to raise_error{TypeError}
        end
      end
      context 'with two arguments 5, :z' do
        it 'returns 5 for []' do
          expect([].inject(5, :z, &block)).to eq 5
        end
        it 'raises no method error for [99]' do
          expect{[99].inject(5, :z, &block)}.to raise_error{NoMethodError}
        end
      end
      context 'with two arguments 5, nil' do
        it 'raises no method error for []' do
          expect{[].inject(5, nil, &block)}.to raise_error{NoMethodError}
        end
      end
    end

    context 'that does *' do
      block = proc { |memo, obj| memo = memo * obj }
      context 'with no arguments' do
        it 'returns nil for []' do
          expect([].inject(&block)).to eq nil
        end
        it 'returns :dummy for [:dummy]' do
          expect([:dummy].inject(&block)).to eq :dummy
        end
        it 'returns 24 for [4,3,2,1]' do
          expect([4,3,2,1].inject(&block)).to eq 24
        end
        it "raises type error for ['d','o','g']" do
          expect{['d','o','g'].inject(&block)}.to raise_error{TypeError}
        end
      end
      context 'with one argument 5' do
        it 'returns 5 for []' do
          expect([].inject(5, &block)).to eq 5
        end
        it 'returns 495 for [99]' do
          expect([99].inject(5, &block)).to eq 495
        end
        it 'returns 120 for [4,3,2,1]' do
          expect([4,3,2,1].inject(5, &block)).to eq 120
        end
        it "raises a type error for ['d','o','g']" do
          expect{['d','o','g'].inject(5, &block)}.to raise_error{TypeError}
        end
      end
    end

    context 'that uses undefined methods' do
      block = proc { zzz }
      context 'with no arguments' do
        it 'returns nil for []' do
          expect([].inject(&block)).to eq nil
        end
        it 'returns :dummy for [:dummy]' do
          expect([:dummy].inject(&block)).to eq :dummy
        end
        it 'raises no method error for [4,3,2,1]' do
          expect{[4,3,2,1].inject(&block)}.to raise_error{NoMethodError}
        end
      end
      context 'with one argument 5' do
        it 'returns nil for []' do
          expect([].inject(5, &block)).to eq 5
        end
        it 'raises name error for [99]' do
          expect{[99].inject(5, &block)}.to raise_error{NameError}
        end
      end
    end

  end

  context 'when injected with no block' do

    context 'and symbol :+' do
      context 'but no other arguments' do
        it 'returns nil for []' do
          expect([].inject(:+)).to eq nil
        end
        it 'returns 99 for [99]' do
          expect([99].inject(:+)).to eq 99
        end
        it 'returns 10 for [4,3,2,1]' do
          expect([4,3,2,1].inject(:+)).to eq 10
        end
        it "returns 'dog' for ['d','o','g']" do
          expect(['d','o','g'].inject(:+)).to eq 'dog'
        end
      end
      context 'plus argument 5' do
        it 'returns 5 for []' do
          expect([].inject(5, :+)).to eq 5
        end
        it 'returns 104 for [99]' do
          expect([99].inject(5, :+)).to eq 104
        end
        it 'returns 15 for [4,3,2,1]' do
          expect([4,3,2,1].inject(5, :+)).to eq 15
        end
        it "raises a type error for ['d','o','g']" do
          expect{['d','o','g'].inject(5, :+)}.to raise_error{TypeError}
        end
      end
    end

    context 'and symbol :*' do
      context 'but no other arguments' do
        it 'returns nil for []' do
          expect([].inject(:*)).to eq nil
        end
        it 'returns 99 for [99]' do
          expect([99].inject(:*)).to eq 99
        end
        it 'returns 24 for [4,3,2,1]' do
          expect([4,3,2,1].inject(:*)).to eq 24
        end
        it "raises type error for ['d','o','g']" do
          expect{['d','o','g'].inject(:*)}.to raise_error{TypeError}
        end
      end
      context 'plus argument 5' do
        it 'returns 5 for []' do
          expect([].inject(5, :*)).to eq 5
        end
        it 'returns 495 for [99]' do
          expect([99].inject(5, :*)).to eq 495
        end
        it 'returns 120 for [4,3,2,1]' do
          expect([4,3,2,1].inject(5, :*)).to eq 120
        end
        it "raises a type error for ['d','o','g']" do
          expect{['d','o','g'].inject(5, :*)}.to raise_error{TypeError}
        end
      end
    end

    context 'and symbol :z' do
      context 'but no other arguments' do
        it 'returns nil for []' do
          expect([].inject(:z)).to eq nil
        end
        it 'returns 99 for [99]' do
          expect([99].inject(:z)).to eq 99
        end
        it 'raises no method error for [4,3,2,1]' do
          expect{[4,3,2,1].inject(:z)}.to raise_error{NoMethodError}
        end
      end
      context 'plus argument 5' do
        it 'returns 5 for []' do
          expect([].inject(5, :z)).to eq 5
        end
        it 'raises no method error for [99]' do
          expect{[99].inject(5, :z)}.to raise_error{NoMethodError}
        end
      end
    end

    context 'and argument nil' do
      context 'but no other arguments' do
        it 'raises type error for []' do
          expect{[].inject(nil)}.to raise_error{TypeError}
        end
      end
      context 'plus argument 5' do
        it 'raises type error for []' do
          expect{[].inject(5, nil)}.to raise_error{TypeError}
        end
      end
    end

  end

end