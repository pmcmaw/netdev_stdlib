# encoding: utf-8

Puppet::Type.newtype(:radius_global) do
  @doc = 'Configure global radius settings'

  apply_to_all

  newparam(:name, namevar: true) do
    desc 'Resource identifier, not used to manage the device'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  newproperty(:enable) do
    desc 'Enable or disable radius functionality [true|false]'
    newvalues(:true, :false)
  end

  newproperty(:key) do
    desc 'Encryption key (plaintext or in hash form depending on key_format)'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  newproperty(:key_format) do
    desc 'Encryption key format [0-7]'
    munge { |v| Integer(v) }
  end

  newproperty(:retransmit_count) do
    desc 'How many times to retransmit'
    munge { |v| Integer(v) }
  end

  newproperty(:source_interface, array_matching: :all) do
    desc 'The source interface used for RADIUS packets (array of strings for multiple).'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  newproperty(:timeout) do
    desc 'Number of seconds before the timeout period ends'
    munge { |v| Integer(v) }
  end

  newproperty(:vrf, array_matching: :all) do
    desc 'The VRF associated with source_interface (array of strings for multiple).'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end
end
