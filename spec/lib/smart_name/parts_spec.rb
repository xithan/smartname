# encoding: utf-8
require_relative "../../spec_helper"

RSpec.describe SmartName::Parts do
  describe 'parts and pieces' do
    it 'produces simple strings for parts' do
      expect('A+B+C+D'.to_name.parts).to eq(%w( A B C D ))
    end

    it 'produces simple name objects for part_names' do
      expect('A+B+C+D'.to_name.part_names).to eq(%w( A B C D ).map(&:to_name))
    end

    it 'produces compound strings for pieces' do
      expect('A+B+C+D'.to_name.pieces).to eq(%w( A B C D A+B A+B+C A+B+C+D ))
    end

    it 'produces compound name objects for piece_names' do
      expect('A+B+C+D'.to_name.piece_names).to eq(
        %w( A B C D A+B A+B+C A+B+C+D ).map(&:to_name)
      )
    end
  end

  describe '#left_name' do
    it 'returns nil for non junction' do
      expect('a'.to_name.left_name).to eq(nil)
    end

    it 'returns parent for parent' do
      expect('a+b+c+d'.to_name.left_name).to eq('a+b+c')
    end
  end

  describe '#tag_name' do
    it 'returns last part of plus card' do
      expect('a+b+c'.to_name.tag).to eq('c')
    end

    it 'returns name of simple card' do
      expect('a'.to_name.tag).to eq('a')
    end
  end

  describe '#replace_part' do
    it 'replaces first name part' do
      expect('a+b'.to_name.replace_part('a', 'x').to_s).to eq('x+b')
    end
    it 'replaces second name part' do
      expect('a+b'.to_name.replace_part('b', 'x').to_s).to eq('a+x')
    end
    it 'replaces two name parts' do
      expect('a+b+c'  .to_name.replace_part('a+b', 'x').to_s).to eq('x+c')
      expect('a+b+c+d'.to_name.replace_part('a+b', 'e+f').to_s).to eq('e+f+c+d')
    end
    it "doesn't replace two part tag" do
      expect('a+b+c'.to_name.replace_part('b+c', 'x').to_s).to eq('a+b+c')
    end
  end
end
