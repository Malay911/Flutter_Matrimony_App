import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/api_service.dart';
import 'package:matrimony_app/database_helper.dart';
import 'package:matrimony_app/user_class.dart';
import 'user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = 'Guest';
  String userEmail = 'guest@example.com';

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
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Guest';
      userEmail = prefs.getString('userEmail') ?? 'guest@example.com';
    });
  }

  Future<void> _logout(BuildContext context) async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure you want to logout?"),
          content: const Text("You will be logged out of the app."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime minDate = today.subtract(Duration(days: 80 * 365));
    DateTime maxDate = today.subtract(Duration(days: 18 * 365));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? maxDate,
      firstDate: minDate,
      lastDate: maxDate,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = DateFormat('dd-MM-yyyy')
            .format(picked);
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.redAccent, size: 24),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Create Profile',
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
              child: Icon(Icons.menu_open_rounded, color: Colors.white),
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        drawer: SizedBox(
          width: 280,
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.red.shade50],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.red.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/image.png"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          userName,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          userEmail,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.home_rounded,
                    title: "Home",
                    onTap: () => Navigator.pushNamed(context, '/dashboard'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_add_alt_1_rounded,
                    title: "Profiles",
                    onTap: () => Navigator.pushNamed(context, '/userList'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_rounded,
                    title: "Favourite Profiles",
                    onTap: () => Navigator.pushNamed(context, '/favourites'),
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_rounded,
                    title: "About Us",
                    onTap: () => Navigator.pushNamed(context, '/aboutUs'),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout_rounded, color: Colors.white),
                      label: Text(
                        "Logout",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                                          "Name", Icons.person_2_rounded)
                                      .copyWith(counterText: ''),
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
                                  textCapitalization: TextCapitalization.words,
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
                                SizedBox(height: 25),
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
                                  textCapitalization: TextCapitalization.words,
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: phoneController,
                                  decoration:
                                      _buildInputDecoration("Phone", Icons.phone)
                                          .copyWith(counterText: ''),
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
                                _buildSectionHeader("Other Details"),
                                TextFormField(
                                  controller: religionController,
                                  decoration: _buildInputDecoration(
                                      "Religion", Icons.temple_hindu_rounded),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter religion'
                                      : null,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: casteController,
                                  decoration: _buildInputDecoration(
                                      "Caste", Icons.groups_rounded),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter caste'
                                      : null,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: subCasteController,
                                  decoration: _buildInputDecoration(
                                      "Sub Caste", Icons.group_rounded),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter sub caste'
                                      : null,
                                  textCapitalization: TextCapitalization.words,
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
                                  textCapitalization: TextCapitalization.words,
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: occupationController,
                                  decoration: _buildInputDecoration(
                                      "Occupation", Icons.work_outline_rounded),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter occupation'
                                      : null,
                                  textCapitalization: TextCapitalization.words,
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
                    // onPressed: () async {
                    //   if (_formKey.currentState!.validate()) {
                    //     User newUser = User(
                    //       name: nameController.text,
                    //       dob: dobController.text,
                    //       gender: gender,
                    //       maritalStatus: maritalStatus,
                    //       country: selectedCountry,
                    //       state: selectedState,
                    //       city: selectedCity,
                    //       religion: religionController.text,
                    //       caste: casteController.text,
                    //       subCaste: subCasteController.text,
                    //       education: educationController.text,
                    //       occupation: occupationController.text,
                    //       email: emailController.text,
                    //       phone: phoneController.text,
                    //     );

                    //     final databaseHelper = DatabaseHelper.instance;
                    //     int result = await databaseHelper.insertUser(newUser);

                    //     if (result > 0) {
                    //       setState(() {
                    //         userList.insert(0, newUser);
                    //       });
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           content: Text('User added successfully!'),
                    //         ),
                    //       );

                    //       _formKey.currentState!.reset();

                    //       Navigator.pop(context, newUser);
                    //     } else {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           content: Text('Failed to add user.'),
                    //         ),
                    //       );
                    //     }
                    //   }
                    // },
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          User newUser = User(
                            name: nameController.text,
                            dob: dobController.text,
                            gender: gender,
                            maritalStatus: maritalStatus,
                            country: selectedCountry,
                            state: selectedState,
                            city: selectedCity,
                            religion: religionController.text,
                            caste: casteController.text,
                            subCaste: subCasteController.text,
                            education: educationController.text,
                            occupation: occupationController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            isFavorite: false,
                          );

                          User createdUser =
                              await _apiService.createUser(newUser.toJson());
                          _showSuccessSnackBar(
                              context, 'Profile created successfully!');
                          _formKey.currentState!.reset();
                          Navigator.pop(context, createdUser);
                        } catch (e) {
                          _showErrorSnackBar(
                              context, 'Error creating profile: $e');
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
                          'Save Profile',
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
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 4),
        margin: EdgeInsets.all(16),
        elevation: 8,
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 4),
        margin: EdgeInsets.all(16),
        elevation: 8,
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
