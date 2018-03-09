# encoding: utf-8

Puppet::Type.newtype(:snmp_user) do
  @doc = 'Set the SNMP contact name'

  apply_to_all
  ensurable

  newparam(:name, namevar: true) do
    desc 'The name of the SNMP user'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  newproperty(:version) do
    desc 'SNMP version [v1|v2|v2c|v3]'

    newvalues(:v1, :v2, :v2c, :v3)
  end

  newproperty(:roles, array_matching: :all) do
    desc 'A list of roles associated with this SNMP user'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end

    def should_to_s(new_value = @should)
      self.class.format_value_for_display(new_value)
    end

    def to_s?(current_value = @is)
      self.class.format_value_for_display(current_value)
    end
  end

  newproperty(:auth) do
    desc 'Authentication mode [md5|sha]'
    newvalues(:md5, :sha)
  end

  newproperty(:password) do
    desc 'Cleartext password for the user'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  newproperty(:privacy) do
    desc 'Privacy encryption method [aes128|des]'
    newvalues(:aes128, :des)
  end

  newproperty(:private_key) do
    desc 'Private key in hexadecimal string'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  newparam(:localized_key) do
    desc 'If true, password needs to be a hexadecimal value'
    newvalues(:true, :false)
  end

  newparam(:enforce_privacy) do
    desc 'If true, message encryption is enforced'
    newvalues(:true, :false)
  end

  newproperty(:engine_id) do
    desc 'Necessary if the SNMP engine is encrypting data'

    validate do |value|
      raise "value #{value.inspect} is invalid, must be a String." unless value.is_a? String
      super(value)
    end
  end

  def self.title_patterns
    identity = nil # optimization in Puppet core
    name = [:name, identity]
    version = [:version, ->(x) { x.to_sym }]
    [
      [%r{^([^:]*)$},                 [name]],
      [%r{^([^:]*):([^:]*)$},         [name, version]],
    ]
  end
end
