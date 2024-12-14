part of 'pages.dart';

class ShippingCalculatorPage extends StatefulWidget {
  const ShippingCalculatorPage({Key? key}) : super(key: key);

  @override
  State<ShippingCalculatorPage> createState() => _ShippingCalculatorPageState();
}

class _ShippingCalculatorPageState extends State<ShippingCalculatorPage> {
  String? selectedShipping = 'jne'; // Default shipping method
  String? selectedOriginProvince;
  String? selectedOriginCity;
  String? selectedDestProvince;
  String? selectedDestCity;
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShippingViewModel>(context, listen: false).fetchProvinces();
    });
  }

  @override
  Widget build(BuildContext context) {
    final shippingVm = Provider.of<ShippingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Calculator'),
      ),
      body: _buildBody(shippingVm),
    );
  }

  Widget _buildBody(ShippingViewModel shippingVm) {
    switch (shippingVm.provinces.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.error:
        return Center(
          child: Text(
            shippingVm.provinces.message ?? 'An error occurred',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        );
      case Status.completed:
        return _buildContent(shippingVm);
      default:
        return const Center(
          child: Text(
            'Something went wrong!',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        );
    }
  }

  Widget _buildContent(ShippingViewModel shippingVm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Shipping Method and Weight
          _buildShippingMethodAndWeight(),

          const SizedBox(height: 24),

          // Origin Province and City
          const Text(
            'Origin',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildOriginDropdowns(shippingVm),

          const SizedBox(height: 24),

          // Destination Province and City
          const Text(
            'Destination',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildDestinationDropdowns(shippingVm),

          const SizedBox(height: 32),

          // Calculate Button and Results
          _buildCalculateButton(shippingVm),
        ],
      ),
    );
  }

  Widget _buildShippingMethodAndWeight() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedShipping,
            decoration: const InputDecoration(labelText: 'Shipping'),
            items: ['jne', 'pos', 'tiki'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.toUpperCase()),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedShipping = newValue;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: weightController,
            decoration: const InputDecoration(labelText: 'Weight (grams)'),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildOriginDropdowns(ShippingViewModel shippingVm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: selectedOriginProvince,
          decoration: const InputDecoration(labelText: 'Origin Province'),
          items: shippingVm.provinces.data?.map((province) {
            return DropdownMenuItem<String>(
              value: province.provinceId,
              child: Text(province.province ?? ''),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedOriginProvince = newValue;
              selectedOriginCity = null; // Reset dependent dropdown
            });
            if (newValue != null) {
              shippingVm.fetchOriginCities(
                  newValue); // Fetch cities for origin province
            }
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedOriginCity,
          decoration: const InputDecoration(labelText: 'Origin City'),
          items: shippingVm.originCities.data?.map((city) {
                return DropdownMenuItem<String>(
                  value: city.cityId,
                  child: Text(city.cityName ?? ''),
                );
              }).toList() ??
              [],
          onChanged: (newValue) {
            setState(() {
              selectedOriginCity = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDestinationDropdowns(ShippingViewModel shippingVm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: selectedDestProvince,
          decoration: const InputDecoration(labelText: 'Destination Province'),
          items: shippingVm.provinces.data?.map((province) {
            return DropdownMenuItem<String>(
              value: province.provinceId,
              child: Text(province.province ?? ''),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedDestProvince = newValue;
              selectedDestCity = null; // Reset dependent dropdown
            });
            if (newValue != null) {
              shippingVm.fetchDestinationCities(
                  newValue); // Fetch cities for destination province
            }
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedDestCity,
          decoration: const InputDecoration(labelText: 'Destination City'),
          items: shippingVm.destinationCities.data?.map((city) {
                return DropdownMenuItem<String>(
                  value: city.cityId,
                  child: Text(city.cityName ?? ''),
                );
              }).toList() ??
              [],
          onChanged: (newValue) {
            setState(() {
              selectedDestCity = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCalculateButton(ShippingViewModel shippingVm) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (weightController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter the weight.')),
              );
              return;
            }

            if (selectedOriginCity == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select an origin city.')),
              );
              return;
            }

            if (selectedDestCity == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please select a destination city.')),
              );
              return;
            }

            if (selectedShipping == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please select a shipping method.')),
              );
              return;
            }

            shippingVm.calculateShippingCost(
              origin: selectedOriginCity!,
              destination: selectedDestCity!,
              weight: int.tryParse(weightController.text) ?? 0,
              courier: selectedShipping!,
            );
          },
          child: const Text('Calculate Shipping Cost'),
        ),
        const SizedBox(height: 24),

        // Show results dynamically
        _buildShippingCostResults(shippingVm),
      ],
    );
  }

  Widget _buildShippingCostResults(ShippingViewModel shippingVm) {
    switch (shippingVm.costs.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        final costs = shippingVm.costs.data as List<dynamic>;
        if (costs.isEmpty) {
          return const Text(
            'No results to display.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: costs.map((cost) {
            final service = cost['service'] ?? 'Unknown Service';
            final price = cost['cost'][0]['value'] ?? 'N/A';
            final etd = cost['cost'][0]['etd'] ?? 'N/A';
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$service",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("Biaya: Rp $price"),
                  Text("Estimasi sampai: $etd hari"),
                ],
              ),
            );
          }).toList(),
        );
      case Status.error:
        return Text(
          "Error: ${shippingVm.costs.message}",
          style: const TextStyle(color: Colors.red),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
