actions :sync

attribute :source,                    :kind_of => String,   :name_attribute => true, :required => true
attribute :destination,               :kind_of => String,   :required => true
attribute :recursive,                 :kind_of => [ TrueClass, FalseClass ],  :default => false

attribute :includes,                  :kind_of => Array,    :default => [ ]
attribute :excludes,                  :kind_of => Array,    :default => [ ]

attribute :aws_access_key,            :kind_of => String
attribute :aws_secret_access_key,     :kind_of => String

def initialize(*args)
  super
  @action = :sync
end

