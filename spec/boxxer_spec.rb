RSpec.describe Boxxer do
  subject { Boxxer.call(containers: containers, contents: contents) }
  let(:contents) do
    [{ item: 'A48t2nwTYZ', weight: 0.569 },
     { item: 'VJAyKO40oU', weight: 0.685 },
     { item: 'Urluk8IYZV', weight: 0.824 },
     { item: '0Q5Uq9COfu', weight: 0.827 },
     { item: '1JfLfD1OZK', weight: 0.949 },
     { item: 'kZKsTauesc', weight: 0.954 },
     { item: 'YpojxvzDrI', weight: 0.712 },
     { item: '09MPdgBZqP', weight: 0.909 },
     { item: 'UJDyDHzAmw', weight: 0.716 },
     { item: 'lnSB0OqTBW', weight: 0.503 },
     { item: 'hZlApJ7Y7E', weight: 0.527 },
     { item: '7S9j1bLdJz', weight: 0.515 },
     { item: 'vZiliKSfcT', weight: 0.952 },
     { item: 'f2S5ovLcNl', weight: 0.944 },
     { item: 'apNJnCRVM3', weight: 0.852 },
     { item: 'NwMHiCloda', weight: 0.905 },
     { item: 'eYR1QUA0Bw', weight: 0.758 },
     { item: 'k8zNBB2JGr', weight: 0.563 },
     { item: 'UUzukWSLk2', weight: 0.933 },
     { item: 'xhynofnO1i', weight: 0.996 }]
  end
  let(:containers) do
    [{ length: 47, width: 38, height: 10, tare_weight: 0.019, net_limit: 0.481 },
     { length: 40, width: 28, height: 13, tare_weight: 0.34, net_limit: 0.66 },
     { length: 40, width: 28, height: 80, tare_weight: 0.1, net_limit: 0.7 },
     { length: 40, width: 28, height: 18, tare_weight: 0.5, net_limit: 1.5 },
     { length: 40, width: 28, height: 20, tare_weight: 0.52, net_limit: 2.48 }]
  end

  it do
    expect(subject.instance_variable_get('@largest_container')).to eq({ length: 40, width: 28, height: 20, tare_weight: 0.52, net_limit: 2.48 })
  end
  it do
    subject.containers.each do |container|
      expect(container.instance_variable_get('@contents').sum { |content| content[:weight] }.truncate(3)).to be <= container.net_weight
    end
  end
  it { expect(subject.container_count).to eq(7) }
  it { expect(subject.total_net_weight).to eq(15.591) }
  it { expect(subject.total_gross_weight).to eq(19.212) }
  it do
    expect(subject.containers.map { |container| container.instance_variable_get('@contents') }).to include(
      [{ item: 'xhynofnO1i', weight: 0.996 }, { item: 'kZKsTauesc', weight: 0.954 }, { item: 'hZlApJ7Y7E', weight: 0.527 }],
      [{ item: 'vZiliKSfcT', weight: 0.952 }, { item: '1JfLfD1OZK', weight: 0.949 }, { item: 'A48t2nwTYZ', weight: 0.569 }],
      [{ item: 'f2S5ovLcNl', weight: 0.944 }, { item: 'UUzukWSLk2', weight: 0.933 }, { item: 'k8zNBB2JGr', weight: 0.563 }],
      [{ item: '09MPdgBZqP', weight: 0.909 }, { item: 'NwMHiCloda', weight: 0.905 }, { item: '7S9j1bLdJz', weight: 0.515 }],
      [{ item: 'apNJnCRVM3', weight: 0.852 }, { item: '0Q5Uq9COfu', weight: 0.827 }, { item: 'eYR1QUA0Bw', weight: 0.758 }],
      [{ item: 'Urluk8IYZV', weight: 0.824 }, { item: 'UJDyDHzAmw', weight: 0.716 }, { item: 'YpojxvzDrI', weight: 0.712 }],
      [{ item: 'VJAyKO40oU', weight: 0.685 }, { item: 'lnSB0OqTBW', weight: 0.503 }]
    )
  end
  it 'has a version number' do
    expect(Boxxer::VERSION).not_to be nil
  end
end
