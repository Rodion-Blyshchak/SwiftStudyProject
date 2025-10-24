

enum FuelType{
	case petrol
	case diesel
	case electric
	
	var description: String {
		switch self {
			case .petrol:
				return "Бензин — класика, запах швидкості й трохи ностальгії"
			case .diesel:
				return "Дизель — тягне все, навіть настрій вгору"
			case .electric:
				return "Електрика — тихо, чисто, сучасно"
		}
	}
}
