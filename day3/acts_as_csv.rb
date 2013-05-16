module ActsAsCSVdummy
    attr_accessor :headers, :contents
    def initialize
	@contents = [['line1itefile1','l1i2'],['l2i1','l2i2']]
	@headers = ['header1', 'another header']
    end
end

module ActsAsCSV
    attr_accessor :headers, :contents
    def initialize
	file = File.new 'rubycsv.txt'
	@contents = []
	@headers = file.gets.chomp.split(', ')
	file.each do |row|
	    @contents.push row.chomp.split(', ')
	end
    end
end

module ActsAsCSVextended
    attr_accessor :headers, :file
    def initialize
	@file = File.new 'animals.txt'
	@headers = file.gets.chomp.split(', ')
    end
    def each
	contents = file.gets.chomp.split(', ')
	row = CSVRow.new(@headers, contents)
	return row
    end
end

class CSVRow
    attr_accessor :headers, :contents
    def initialize(headers, contents)
	@headers = headers
	@contents = contents
    end
    def method_missing name, *args
	heading = name.to_s
	if @headers.index(heading) != nil
	    return @contents[@headers.index(heading)]
	else
	    return 'not found'
	end
    end
end

class RubyCSVdummy
    include ActsAsCSVdummy
end

class RubyCSV
    include ActsAsCSV
end

class RubyCSVextended
    include ActsAsCSVextended
end


describe 'A dummy CSV mixin' do
    it 'should correctly read headers' do
	file = RubyCSVdummy.new
	file.headers[0].should eq 'header1'
	file.headers[1].should eq 'another header'
    end
    it 'should correctly read contents' do
	file = RubyCSVdummy.new
	file.contents[0][0].should eq 'line1itefile1'
	file.contents[0][1].should eq 'l1i2'
	file.contents[1][0].should eq 'l2i1'
	file.contents[1][1].should eq 'l2i2'
    end
end

describe 'A CSV mixin that reads from files' do
    it 'should read headers' do
	file = RubyCSV.new
	file.headers[0].should eq "first"
	file.headers[1].should eq "last"
	file.headers[2].should eq "country"
    end
    it 'should correctly read contents' do
	file = RubyCSV.new
	file.contents[0][0].should eq 'Yukihiro'
	file.contents[0][1].should eq 'Matsumoto'
	file.contents[0][2].should eq 'Japan'
	file.contents[1][0].should eq 'Bruce'
	file.contents[1][1].should eq 'Tate'
	file.contents[1][2].should eq 'USA'
    end
end

describe 'An extended CSV mixin that reads from files' do
    it 'should read headers' do
	csv = RubyCSVextended.new
	csv.headers[0].should eq "one"
	csv.headers[1].should eq "two"
    end
    it 'should read the first line of the file' do
	csv = RubyCSVextended.new
	row = csv.each()
	row.one.should eq "lions" 
	row.two.should eq "tigers"
    end
    it 'should read the second line of the file' do
	csv = RubyCSVextended.new
	row = csv.each()
	row = csv.each()
	row.one.should eq "bears" 
	row.two.should eq "giraffes"
    end
end

