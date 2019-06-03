SwitchPoint.configure do |config|
  config.define_switch_point :common,
                             readonly: :"#{Rails.env}_reader",
                             writable: :"#{Rails.env}"
end
