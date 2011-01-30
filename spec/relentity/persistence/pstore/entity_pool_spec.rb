module Relentity describe Persistence::PStore::EntityPool do

  describe '.root' do

    it 'retrieves and stores the PStore root dir' do
      module Rootless; extend Persistence::PStore::EntityPool; end
      Rootless.root.should == nil
      Rootless.root 'dir'
      Rootless.root.should == 'dir'
    end

  end

end end
