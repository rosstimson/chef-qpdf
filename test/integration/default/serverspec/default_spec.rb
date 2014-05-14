# Encoding: utf-8

require_relative 'spec_helper'

describe 'installs qpdf' do
  describe file('/usr/bin/qpdf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end

  describe command('qpdf --version') do
    it { should return_exit_status 0 }
    it { should return_stdout(/qpdf version \d+\.\d+\.\d+.*/m) }
  end
end
