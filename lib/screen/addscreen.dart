import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Vehicles { bike, car }

enum Brands {
  honda,
  hero,
  bajaj,
  hyundai,
  suzuki,
  toyota,
  skoda,
  royalenfield,
  mahindra
}

enum Fuels { petrol, diesel }

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final formKey =GlobalKey<FormState>();

  final ValueNotifier<Brands> _selectedBrand = ValueNotifier(Brands.honda);
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
      body: Container(
        color: const Color.fromARGB(255, 226, 228, 211),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Vehicle No:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: TextFormField(
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Vehicle number';
                      } else if (value.length > 10) {
                        return 'Please enter valid number';
                      }else if(value.length < 8){
                        return 'Please enter valid number';
                      }
                      return null;
                    }, 
                          controller: _numberController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'eg:KL11AA1234',
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Select Brand',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ValueListenableBuilder<Brands>(
                          valueListenable: _selectedBrand,
                          builder: (context, v, _) {
                            return DropdownButton<Brands>(
                              value: v,
                              hint: const Text('Choose brand'),
                              items: Brands.values.map((d) {
                                return DropdownMenuItem(
                                  child: Text(d.name),
                                  value: d,
                                );
                              }).toList(),
                              onChanged: (Brands? newvalue) {
                                if (newvalue != null) {
                                  _selectedBrand.value = newvalue;
                                }
                              },
                            );
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Select vehicle',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ValueListenableBuilder<Vehicles>(
                          valueListenable: _selectedVehicle,
                          builder: (context, r, child) {
                            return DropdownButton<Vehicles>(
                              value: r,
                              hint: const Text('Vehicle type'),
                              onChanged: (Vehicles? newselection) {
                                if (newselection != null) {
                                  _selectedVehicle.value = newselection;
                                }
                              },
                              items: Vehicles.values.map((e) {
                                return DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e,
                                );
                              }).toList(),
                            );
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Fuel type',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ValueListenableBuilder<Fuels>(
                          valueListenable: _selectedFuel,
                          builder: (context, j, child) {
                            return DropdownButton(
                              value: j,
                              items: Fuels.values.map((g) {
                                return DropdownMenuItem(
                                  child: Text(g.name),
                                  value: g,
                                );
                              }).toList(),
                              onChanged: (Fuels? newvalue) {
                                if (newvalue != null) {
                                  _selectedFuel.value = newvalue;
                                }
                              },
                            );
                          })
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final isValidForm =formKey.currentState!.validate();
                        if(isValidForm){ if (_selectedVehicle.value == Vehicles.bike) {
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
                        Navigator.of(context).pop();}
                       
                      },
                      child: const Text('Submit'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
