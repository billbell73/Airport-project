shared_examples 'a weather inquirer' do

	let(:inquirer) { described_class.new }

	it 'can check weather status' do
    inquirer.stub(:weather_status => "sunny")
    expect(inquirer.weather_status).to eq "sunny"
  end

  it 'can tell if weather good' do
    inquirer.stub(:weather_good? => true)
    expect(inquirer.weather_good?).to be_true
  end

  it 'can receive message \'Sorry. Too Stormy to take off\'' do
  	expect(inquirer.stormy_abort_take_off_msg).to eq "Sorry. Too Stormy to take off"
  end

end

	