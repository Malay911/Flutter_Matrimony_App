import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/database_helper.dart';
import 'user_class.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  EditUserPage({required this.user});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController subCasteController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  String? gender;
  String? maritalStatus;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  DateTime? selectedDate;

  final Map<String, List<String>> countryStateMap = {
    'USA': ['California', 'Texas', 'New York', 'Florida', 'Illinois'],
    'India': ['Maharashtra', 'Karnataka', 'Tamil Nadu', 'Delhi', 'Gujarat'],
    'Canada': ['Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba'],
    'UK': ['England', 'Scotland', 'Wales', 'Northern Ireland'],
    'Australia': [
      'New South Wales',
      'Victoria',
      'Queensland',
      'Western Australia',
      'South Australia'
    ],
  };

  final Map<String, List<String>> stateCityMap = {
    'California': [
      'Los Angeles',
      'San Francisco',
      'San Diego',
      'Sacramento',
      'San Jose'
    ],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio', 'Fort Worth'],
    'New York': ['New York City', 'Buffalo', 'Rochester', 'Albany', 'Syracuse'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville', 'Fort Lauderdale'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad'],
    'Karnataka': ['Bangalore', 'Mysore', 'Mangalore', 'Hubli', 'Belgaum'],
    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Tiruchirappalli',
      'Salem'
    ],
    'Delhi': ['New Delhi', 'Rohini', 'Dwarka', 'Karol Bagh', 'Pitampura'],
    'Gujarat': ['Ahmedabad', 'Jamnagar', 'Rajkot', 'Porbandar', 'Junagadh'],
    'Ontario': ['Toronto', 'Ottawa', 'Mississauga', 'Brampton', 'Hamilton'],
    'Quebec': ['Montreal', 'Quebec City', 'Laval', 'Gatineau', 'Sherbrooke'],
    'British Columbia': [
      'Vancouver',
      'Victoria',
      'Surrey',
      'Burnaby',
      'Richmond'
    ],
    'England': ['London', 'Manchester', 'Birmingham', 'Liverpool', 'Bristol'],
    'Scotland': ['Edinburgh', 'Glasgow', 'Aberdeen', 'Dundee', 'Inverness'],
    'Wales': ['Cardiff', 'Swansea', 'Newport', 'Wrexham', 'Bangor'],
    'Northern Ireland': [
      'Belfast',
      'Derry',
      'Lisburn',
      'Newtownabbey',
      'Bangor'
    ],
    'New South Wales': [
      'Sydney',
      'Newcastle',
      'Wollongong',
      'Tamworth',
      'Gosford'
    ],
    'Victoria': ['Melbourne', 'Geelong', 'Ballarat', 'Bendigo', 'Shepparton'],
    'Queensland': [
      'Brisbane',
      'Gold Coast',
      'Cairns',
      'Townsville',
      'Rockhampton'
    ],
    'Western Australia': [
      'Perth',
      'Mandurah',
      'Bunbury',
      'Geraldton',
      'Albany'
    ],
    'South Australia': [
      'Adelaide',
      'Mount Gambier',
      'Whyalla',
      'Murray Bridge',
      'Port Augusta'
    ],
  };

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name ?? '';
    dobController.text = widget.user.dob ?? '';
    emailController.text = widget.user.email ?? '';
    phoneController.text = widget.user.phone ?? '';
    countryController.text = widget.user.country ?? '';
    stateController.text = widget.user.state ?? '';
    religionController.text = widget.user.religion ?? '';
    casteController.text = widget.user.caste ?? '';
    subCasteController.text = widget.user.subCaste ?? '';
    educationController.text = widget.user.education ?? '';
    occupationController.text = widget.user.occupation ?? '';
    gender = widget.user.gender;
    maritalStatus = widget.user.maritalStatus;

    selectedCountry = widget.user.country;
    selectedState = widget.user.state;
    selectedCity = widget.user.city;
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime today = DateTime.now();
  //   DateTime minDate = today.subtract(Duration(days: 80 * 365));
  //   DateTime maxDate = today.subtract(Duration(days: 18 * 365));
  //
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate ?? maxDate,
  //     firstDate: minDate,
  //     lastDate: maxDate,
  //   );
  //
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       dobController.text = "${picked.toLocal()}".split(' ')[0];
  //     });
  //   }
  // }
  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime minDate = today.subtract(Duration(days: 80 * 365)); // Minimum age: 80 years
    DateTime maxDate = today.subtract(Duration(days: 18 * 365)); // Maximum age: 18 years

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? maxDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        // Format the picked date to 'dd-MM-yyyy' for display
        dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User',
            style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        backgroundColor: Colors.redAccent[400],
        elevation: 5,
        centerTitle: true,
        leading: IconButton(
          icon: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 24, key: ValueKey('back_icon')),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.red.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Personal Information",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.person_2_rounded),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          maxLength: 50,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z ]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            } else if (value.trim().length < 3) {
                              return 'Name must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        DropdownButtonFormField<String>(
                          value: gender,
                          items: ['Male', 'Female', 'Other']
                              .map((gender) => DropdownMenuItem(
                              value: gender, child: Text(gender)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Gender",
                            prefixIcon: Icon(Icons.group_rounded),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) =>
                          value == null ? 'Please select gender' : null,
                        ),
                        SizedBox(height: 15),
                        // TextFormField(
                        //   controller: dobController,
                        //   readOnly: true,
                        //   onTap: () => _selectDate(context),
                        //   decoration: InputDecoration(
                        //     labelText: "Date of Birth",
                        //     prefixIcon: Icon(Icons.date_range_rounded),
                        //     prefixIconColor: Colors.redAccent,
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10)),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please select Date of Birth';
                        //     }
                        //     DateTime dob =
                        //     DateFormat('yyyy-MM-dd').parse(value);
                        //     DateTime today = DateTime.now();
                        //     int age = today.year - dob.year;
                        //     if (dob.isAfter(
                        //         today.subtract(Duration(days: age * 365)))) {
                        //       age--;
                        //     }
                        //     if (age < 18) {
                        //       return 'Age must be at least 18 years';
                        //     } else if (age > 80) {
                        //       return 'Age cannot be more than 80 years';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        TextFormField(
                          controller: dobController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            labelText: "Date of Birth",
                            prefixIcon: Icon(Icons.date_range_rounded),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select Date of Birth';
                            }
                            DateTime dob = DateFormat('dd-MM-yyyy').parse(value);
                            DateTime today = DateTime.now();
                            int age = today.year - dob.year;
                            if (dob.isAfter(today.subtract(Duration(days: age * 365)))) {
                              age--;
                            }
                            if (age < 18) {
                              return 'Age must be at least 18 years';
                            } else if (age > 80) {
                              return 'Age cannot be more than 80 years';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        DropdownButtonFormField<String>(
                          value: maritalStatus,
                          items: ['Single', 'Divorced', 'Widowed']
                              .map((status) => DropdownMenuItem(
                              value: status, child: Text(status)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              maritalStatus = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Marital Status",
                            prefixIcon: Icon(Icons.favorite_rounded),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) => value == null
                              ? 'Please select marital status'
                              : null,
                        ),
                        SizedBox(height: 25),
                        Text("Contact Information",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedCountry,
                          items: countryStateMap.keys
                              .map((country) => DropdownMenuItem(
                              value: country, child: Text(country)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCountry = value;
                              selectedState = null;
                              selectedCity = null;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Country",
                            prefixIcon: Icon(Icons.public_rounded),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) =>
                          value == null ? 'Please select a country' : null,
                        ),
                        SizedBox(height: 15),
                        if (selectedCountry != null)
                          DropdownButtonFormField<String>(
                            value: selectedState,
                            items: countryStateMap[selectedCountry]!
                                .map((state) => DropdownMenuItem(
                                value: state, child: Text(state)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedState = value;
                                selectedCity = null;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "State",
                              prefixIcon: Icon(Icons.location_city_rounded),
                              prefixIconColor: Colors.redAccent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) =>
                            value == null ? 'Please select a state' : null,
                          ),
                        SizedBox(height: 15),
                        if (selectedState != null)
                          DropdownButtonFormField<String>(
                            value: selectedCity,
                            items: stateCityMap[selectedState]!
                                .map((city) => DropdownMenuItem(
                                value: city, child: Text(city)))
                                .toList(),
                            onChanged: (value) =>
                                setState(() => selectedCity = value),
                            decoration: InputDecoration(
                              labelText: "City",
                              prefixIcon: Icon(Icons.house_rounded),
                              prefixIconColor: Colors.redAccent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) =>
                            value == null ? 'Please select a city' : null,
                          ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                                    .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value == null ||
                                value.length != 10 ||
                                !RegExp(r"^[0-9]{10}").hasMatch(value)) {
                              return 'Please enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25),
                        Text("Other Details",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: religionController,
                          decoration: InputDecoration(
                            labelText: "Religion",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: FaIcon(
                                FontAwesomeIcons.om,
                                size: 22,
                              ),
                            ),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter religion' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: casteController,
                          decoration: InputDecoration(
                            labelText: "Caste",
                            prefixIcon: Icon(Icons.groups_outlined),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter caste' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: subCasteController,
                          decoration: InputDecoration(
                            labelText: "Sub Caste",
                            prefixIcon: Icon(Icons.group_rounded),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter sub caste' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: educationController,
                          decoration: InputDecoration(
                            labelText: "Higher Education",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: FaIcon(
                                FontAwesomeIcons.userGraduate,
                                size: 22,
                              ),
                            ),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter education' : null,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: occupationController,
                          decoration: InputDecoration(
                            labelText: "Occupation",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: FaIcon(
                                FontAwesomeIcons.userDoctor,
                                size: 22,
                              ),
                            ),
                            prefixIconColor: Colors.redAccent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Please enter occupation' : null,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Save the form values to the user object
                    widget.user.name = nameController.text;
                    widget.user.dob = dobController.text;
                    widget.user.gender = gender;
                    widget.user.maritalStatus = maritalStatus;
                    widget.user.country = selectedCountry;
                    widget.user.state = selectedState;
                    widget.user.city = selectedCity;
                    widget.user.religion = religionController.text;
                    widget.user.caste = casteController.text;
                    widget.user.subCaste = subCasteController.text;
                    widget.user.education = educationController.text;
                    widget.user.occupation = occupationController.text;
                    widget.user.email = emailController.text;
                    widget.user.phone = phoneController.text;

                    if (widget.user.id == null) {
                      await DatabaseHelper.instance.insertUser(widget.user);
                    } else {
                      await DatabaseHelper.instance.updateUser(widget.user);
                    }
                    Navigator.pop(context, widget.user);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.redAccent[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
