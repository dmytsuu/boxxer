RSpec.describe Boxxer do
  subject { Boxxer.call(containers: containers, weights: weights) }
  let(:weights) do
    [0.569, 0.685, 0.824, 0.827, 0.949, 0.954, 0.712, 0.909, 0.716, 0.503,
     0.527, 0.515, 0.952, 0.944, 0.852, 0.905, 0.758, 0.563, 0.933, 0.996]
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
      expect(container.instance_variable_get('@weights').sum.truncate(3)).to be <= container.net_weight
    end
  end
  it { expect(subject.container_count).to eq(7) }
  it { expect(subject.total_net_weight).to eq(15.591) }
  it { expect(subject.total_gross_weight).to eq(19.212) }
  it do
    expect(subject.containers.map { |container| container.instance_variable_get('@weights') }).to include(
      [0.996, 0.954, 0.527], [0.952, 0.949, 0.569], [0.944, 0.933, 0.563], [0.909, 0.905, 0.515],
      [0.852, 0.827, 0.758], [0.824, 0.716, 0.712], [0.685, 0.503]
    )
  end
  it 'has a version number' do
    expect(Boxxer::VERSION).not_to be nil
  end
end
