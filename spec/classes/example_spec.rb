require 'spec_helper'

describe 'sysctl' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "sysctl class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('sysctl::params') }
          it { is_expected.to contain_class('sysctl::install').that_comes_before('sysctl::config') }
          it { is_expected.to contain_class('sysctl::config') }
          it { is_expected.to contain_class('sysctl::service').that_subscribes_to('sysctl::config') }

          it { is_expected.to contain_service('sysctl') }
          it { is_expected.to contain_package('sysctl').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'sysctl class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('sysctl') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
