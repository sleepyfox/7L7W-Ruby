class Roman
    def self.method_missing name, *args
	equalities = [ ['IV', 'IIII'], 
	               ['IX','VIIII'], 
		       ['XL','XXXX'], 
		       ['XC','LXXXX'] ]
	numeral = name.to_s
	equalities.each do |original,replacement|
	  numeral.gsub!(original, replacement)
	end

	return numeral.count('I') +
	       numeral.count('V') * 5 +
	       numeral.count('X') * 10 +
	       numeral.count('L') * 50 + 
	       numeral.count('C') * 100
    end
end

describe 'When using Roman numerals' do
    it 'I should be 1' do
	Roman.I.should eq 1
    end
    it 'II should be 2' do
	Roman.II.should eq 2
    end
    it 'III should be 3' do
	Roman.III.should eq 3
    end
    it 'IIII should be 4' do
	Roman.IIII.should eq 4
    end
    it 'V should be 5' do
	Roman.V.should eq 5
    end
    it 'IV should be 4' do
	Roman.IV.should eq 4
    end
    it 'X should be 10' do
	Roman.X.should eq 10
    end
    it 'IX should be 9' do
	Roman.IX.should eq 9
    end
    it 'XVI should be 16' do
	Roman.XVI.should eq 16
    end
    it 'XXX should be 30' do
	Roman.XXX.should eq 30
    end
    it 'XL should be 40' do
	Roman.XL.should eq 40
    end
    it 'XLIX should be 49' do
	Roman.XLIX.should eq 49
    end
    it 'XC should be 90' do
	Roman.XC.should eq 90
    end
    it 'XCIV should be 94' do
	Roman.XCIV.should eq 94
    end
    it 'C should be 100' do
	Roman.C.should eq 100
    end
    it 'CCCL should be 350' do
	Roman.CCCL.should eq 350
    end
end

