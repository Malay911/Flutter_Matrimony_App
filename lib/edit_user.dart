import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/database_helper.dart';
import 'user_class.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  const EditUserPage({super.key, required this.user});

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

    // Validate marital status against available options
    if (widget.user.maritalStatus != null &&
        !['Single', 'Married', 'Divorced', 'Widowed']
            .contains(widget.user.maritalStatus)) {
      widget.user.maritalStatus = 'Single'; // Set default if invalid value
    }
    maritalStatus = widget.user.maritalStatus;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime minDate =
        today.subtract(const Duration(days: 80 * 365)); // Minimum age: 80 years
    DateTime maxDate =
        today.subtract(const Duration(days: 18 * 365)); // Maximum age: 18 years

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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 5,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15),
              height: 1,
              color: Colors.redAccent.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.redAccent),
      prefixIcon: Icon(icon, color: Colors.redAccent),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.redAccent.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.redAccent.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red.shade400,
              Colors.redAccent.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader("Personal Information"),
                              TextFormField(
                                controller: nameController,
                                decoration: _buildInputDecoration(
                                    "Name", Icons.person_2_rounded),
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
                                onChanged: (value) =>
                                    setState(() => gender = value),
                                decoration: _buildInputDecoration(
                                    "Gender", Icons.group_rounded),
                                validator: (value) => value == null
                                    ? 'Please select gender'
                                    : null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: dobController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                decoration: _buildInputDecoration(
                                    "Date of Birth", Icons.date_range_rounded),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select Date of Birth';
                                  }
                                  DateTime dob =
                                      DateFormat('dd-MM-yyyy').parse(value);
                                  DateTime today = DateTime.now();
                                  int age = today.year - dob.year;
                                  if (dob.isAfter(today
                                      .subtract(Duration(days: age * 365)))) {
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
                                items: [
                                  'Single',
                                  'Married',
                                  'Divorced',
                                  'Widowed'
                                ]
                                    .map((status) => DropdownMenuItem(
                                        value: status, child: Text(status)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    maritalStatus = value;
                                  });
                                },
                                decoration: _buildInputDecoration(
                                    "Marital Status", Icons.favorite_rounded),
                                validator: (value) => value == null
                                    ? 'Please select marital status'
                                    : null,
                              ),
                              _buildSectionHeader("Contact Information"),
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
                                decoration: _buildInputDecoration(
                                    "Country", Icons.public_rounded),
                                validator: (value) => value == null
                                    ? 'Please select a country'
                                    : null,
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
                                  decoration: _buildInputDecoration(
                                      "State", Icons.location_city_rounded),
                                  validator: (value) => value == null
                                      ? 'Please select a state'
                                      : null,
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
                                  decoration: _buildInputDecoration(
                                      "City", Icons.house_rounded),
                                  validator: (value) => value == null
                                      ? 'Please select a city'
                                      : null,
                                ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: emailController,
                                decoration:
                                    _buildInputDecoration("Email", Icons.email),
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
                                decoration:
                                    _buildInputDecoration("Phone", Icons.phone),
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
                              _buildSectionHeader("Other Details"),
                              TextFormField(
                                controller: religionController,
                                decoration: _buildInputDecoration(
                                    "Religion", Icons.temple_hindu_rounded),
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter religion'
                                    : null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: casteController,
                                decoration: _buildInputDecoration(
                                    "Caste", Icons.groups_rounded),
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter caste'
                                    : null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: subCasteController,
                                decoration: _buildInputDecoration(
                                    "Sub Caste", Icons.group_rounded),
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter sub caste'
                                    : null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: educationController,
                                decoration: _buildInputDecoration(
                                    "Higher Education",
                                    FontAwesomeIcons.userGraduate),
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter education'
                                    : null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: occupationController,
                                decoration: _buildInputDecoration(
                                    "Occupation", Icons.work_outline_rounded),
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter occupation'
                                    : null,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Update the user object with new values
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

                      try {
                        // Update in database
                        await DatabaseHelper.instance.updateUser(widget.user);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Profile updated successfully!')),
                        );

                        // Return the updated user to the previous screen
                        Navigator.pop(context, widget.user);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error updating profile: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: Colors.redAccent.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save_rounded, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Save Changes',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
