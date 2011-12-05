def initialize(name, run_context=nil)
  super(name, run_context)
  @action = :create
end

actions :create

attribute :cn,    :kind_of => String, :default => 'localhost'
attribute :owner, :kind_of => String, :default => 'root'
attribute :group, :kind_of => String, :default => 'root'
attribute :mode,  :kind_of => String, :default => '0440'

