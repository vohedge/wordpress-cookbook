require 'spec_helper'

describe process('apache2') do
  it { should be_running }
end

describe port(80) do
  it { should be_listening.with('tcp') }
end

