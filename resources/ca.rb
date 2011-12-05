def initialize(name, run_context=nil)
  super(name, run_context)
  @action = :create
end

actions :create

attribute :symlink, :kind_of => [TrueClass,FalseClass], :default => true
attribute :owner,   :kind_of => String, :default => 'root'
attribute :group,   :kind_of => String, :default => 'root'
attribute :mode,    :kind_of => String, :default => '0444'

