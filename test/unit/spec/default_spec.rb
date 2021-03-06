# Encoding: utf-8

require_relative 'spec_helper'

describe 'qpdf::default' do
  context 'Common on all platforms' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'installs qpdf' do
      expect(chef_run).to install_package('qpdf')
    end
  end

  context 'On RHEL family platforms' do
    before do
      Fauxhai.mock(platform: 'centos', version: '6.5')
    end

    let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5').converge(described_recipe) } # rubocop:disable LineLength

    it 'includes yum cookbook dependency' do
      expect(chef_run).to include_recipe('yum')
    end

    it 'install qpdf runtime / devel libs' do
      expect(chef_run).to install_package('qpdf-devel')
    end
  end

  context 'On Debian family platforms' do
    before do
      Fauxhai.mock(platform: 'debian', version: '7.4')
    end

    let(:chef_run) { ChefSpec::Runner.new(platform: 'debian', version: '7.4').converge(described_recipe) } # rubocop:disable LineLength

    it 'includes apt cookbook dependency' do
      expect(chef_run).to include_recipe('apt')
    end

    it 'install qpdf runtime / devel libs' do
      expect(chef_run).to install_package('libqpdf-dev')
    end
  end
end
