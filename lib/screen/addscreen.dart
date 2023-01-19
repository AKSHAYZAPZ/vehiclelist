import 'package:car_bike_details/screen/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Vehicles { bike, car }

enum Brands {
  ktm,
  hero,
  bajaj,
  royalenfield,
  java,
  yamaha,
  hyundai,
  toyota,
  skoda,
  bmw,
  benz,
  audi
}

enum Fuels { petrol, diesel }

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final ValueNotifier<Brands> _selectedBrand = ValueNotifier(Brands.hero);
  final ValueNotifier<Vehicles> _selectedVehicle = ValueNotifier(Vehicles.bike);
  final ValueNotifier<Fuels> _selectedFuel = ValueNotifier(Fuels.petrol);
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 3, 101),
        title: const Center(
          child: Text(
            'Vehicle form',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Vehicle No",
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 124, 85, 156)),
              ),
              const SizedBox(
                height: 7,
              ),
              Form(
                key: formKey,
                child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  controller: _numberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your vehicle number";
                    } else if (value.length > 10) {
                      return "Please enter a valid vehicle number";
                    } else if (value.length < 8) {
                      return "Please enter valid vehicle number";
                    } else if (!RegExp(
                            r'^[A-Z]{2}[0-9]{1,2}[A-Z]{1,2}[0-9]{4}$')
                        .hasMatch(value)) {
                      return 'Invalid vehicle number';
                    } else {
                      return null;
                    }
                  },
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Brand Name",
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 124, 85, 156)),
              ),
              ValueListenableBuilder<Brands>(
                valueListenable: _selectedBrand,
                builder: (context, value, child) {
                  return DropdownButton<Brands>(
                      isExpanded: true,
                      value: value,
                      items: Brands.values.map((e) {
                        return DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (Brands? newBrand) {
                        if (newBrand != null) {
                          _selectedBrand.value = newBrand;
                        }
                      });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Vehicle Type",
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 124, 85, 156)),
              ),
              ValueListenableBuilder<Vehicles>(
                  valueListenable: _selectedVehicle,
                  builder: (context, v, _) {
                    return DropdownButton<Vehicles>(
                      isExpanded: true,
                      value: v,
                      onChanged: (Vehicles? newValue) {
                        if (newValue != null) {
                          _selectedVehicle.value = newValue;
                        }
                      },
                      items: Vehicles.values.map((d) {
                        return DropdownMenuItem(
                          child: Text(
                            d.name,
                          ),
                          value: d,
                        );
                      }).toList(),
                    );
                  }),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Fuel Type",
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 124, 85, 156)),
              ),
              ValueListenableBuilder<Fuels>(
                valueListenable: _selectedFuel,
                builder: (context, value, child) {
                  return DropdownButton(
                      isExpanded: true,
                      value: value,
                      items: Fuels.values.map((e) {
                        return DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (Fuels? newFuelType) {
                        if (newFuelType != null) {
                          _selectedFuel.value = newFuelType;
                        }
                      });
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm) {
                      if (_selectedVehicle.value == Vehicles.bike) {
                        await FirebaseFirestore.instance
                            .collection('bikelist')
                            .add({
                          'vehicle_no': _numberController.text,
                          'vehicle_brand': _selectedBrand.value.name,
                          'vehicle_type': _selectedVehicle.value.name,
                          'vehicle_fuel': _selectedFuel.value.name
                        });
                      } else {
                        await FirebaseFirestore.instance
                            .collection('carlist')
                            .add({
                          'vehicle_no': _numberController.text,
                          'vehicle_brand': _selectedBrand.value.name,
                          'vehicle_type': _selectedVehicle.value.name,
                          'vehicle_fuel': _selectedFuel.value.name
                        });
                      }
                      _numberController.text = '';
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const ScreenOne();
                        },
                      ));
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
