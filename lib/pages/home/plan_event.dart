import 'package:flutter/material.dart';

class PlanEventPage extends StatefulWidget {
  const PlanEventPage({super.key});

  @override
  State<PlanEventPage> createState() => _PlanEventPageState();
}

class _PlanEventPageState extends State<PlanEventPage> {
  // Event data
  String? _eventType;
  String? _eventLocation;
  String? _vibe;
  String? _eventDuration;

  // Controllers
  final TextEditingController _eventNameCtrl = TextEditingController();
  final TextEditingController _guestsCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _budgetCtrl = TextEditingController();
  final TextEditingController _specialReqCtrl = TextEditingController();

  // Booleans for target audience
  bool _isFamily = false;
  bool _isKids = false;
  bool _isProfessionals = false;
  bool _isOthers = false;

  //Booleans for additional requirements
  bool _isCatering = false;
  bool _isPhotography = false;
  bool _isVideography = false;
  bool _isStages = false;
  bool _isHall = false;
  bool _isFarm = false;

  DateTime? _selectedDate;

  @override
  void dispose() {
    _eventNameCtrl.dispose();
    _guestsCtrl.dispose();
    _budgetCtrl.dispose();
    _countryCtrl.dispose();
    _cityCtrl.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickSingleDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(
        () => _startDateController.text =
            "${picked.day}/${picked.month}/${picked.year}",
      );
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 2)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(
        () => _endDateController.text =
            "${picked.day}/${picked.month}/${picked.year}",
      );
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _startTimeController.text = picked.format(context));
    }
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _endTimeController.text = picked.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Plan Your Event",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Image.asset('lib/assets/logo.png', height: 40),
                  ],
                ),
                const SizedBox(height: 24),

                // 🔸 Form Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tell us about your event',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Event Name
                      const Text(
                        "Event Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _eventNameCtrl,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "e.g., Sarah's 30th Birthday",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Event Type
                      const Text(
                        "Event Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _eventType,
                        items: const [
                          DropdownMenuItem(
                            value: 'Wedding',
                            child: Text('Wedding'),
                          ),
                          DropdownMenuItem(
                            value: 'Birthday',
                            child: Text('Birthday'),
                          ),
                          DropdownMenuItem(
                            value: 'Corporate',
                            child: Text('Corporate'),
                          ),
                          DropdownMenuItem(
                            value: 'Party',
                            child: Text('Party'),
                          ),
                          DropdownMenuItem(
                            value: 'Conference',
                            child: Text('Conference'),
                          ),
                          DropdownMenuItem(
                            value: 'Other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (val) => setState(() => _eventType = val),
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Vibe
                      const Text(
                        "Event Vibe",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _vibe,
                        items: const [
                          DropdownMenuItem(
                            value: 'Casual',
                            child: Text('Casual'),
                          ),
                          DropdownMenuItem(
                            value: 'Formal',
                            child: Text('Formal'),
                          ),
                          DropdownMenuItem(
                            value: 'Educational',
                            child: Text('Educational'),
                          ),
                          DropdownMenuItem(
                            value: 'Family',
                            child: Text('Family'),
                          ),
                          DropdownMenuItem(
                            value: 'Other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (val) => setState(() => _vibe = val),
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Target Audience
                      const Text(
                        "Target Audience",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...[
                        {"label": "Family", "value": _isFamily},
                        {"label": "Kids", "value": _isKids},
                        {"label": "Professionals", "value": _isProfessionals},
                        {"label": "Others", "value": _isOthers},
                      ].map((item) {
                        return CheckboxListTile(
                          title: Text(
                            item["label"] as String,
                            style: const TextStyle(color: Colors.black87),
                          ),
                          value: item["value"] as bool,
                          activeColor: Colors.deepOrange,
                          onChanged: (val) {
                            setState(() {
                              switch (item["label"]) {
                                case "Family":
                                  _isFamily = val!;
                                  break;
                                case "Kids":
                                  _isKids = val!;
                                  break;
                                case "Professionals":
                                  _isProfessionals = val!;
                                  break;
                                case "Others":
                                  _isOthers = val!;
                                  break;
                              }
                            });
                          },
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        );
                      }),
                      const SizedBox(height: 16),

                      // Number of Guests
                      const Text(
                        "Number of Guests",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _guestsCtrl,
                        style: const TextStyle(color: Colors.black87),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "e.g., 50, 100, 200",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Location Type
                      const Text(
                        "Location Type",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _eventLocation,
                        items: const [
                          DropdownMenuItem(
                            value: 'Indoor',
                            child: Text('Indoor'),
                          ),
                          DropdownMenuItem(
                            value: 'Outdoor',
                            child: Text('Outdoor'),
                          ),
                          DropdownMenuItem(
                            value: 'Other',
                            child: Text('Other'),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => _eventLocation = val),
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Country
                      const Text(
                        "Country",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _countryCtrl,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "Enter Country",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // City
                      const Text(
                        "City",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _cityCtrl,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "Enter City",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 🕒 Event Duration
                      const Text(
                        "Event Duration",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RadioListTile<String>(
                        title: const Text(
                          "One Day Event",
                          style: TextStyle(color: Colors.black87),
                        ),
                        value: 'One Day',
                        groupValue: _eventDuration,
                        activeColor: Colors.deepOrange,
                        onChanged: (val) {
                          setState(() {
                            _eventDuration = val;
                            _startDateController.clear();
                            _endDateController.clear();
                            _startTimeController.clear();
                            _endTimeController.clear();
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                      RadioListTile<String>(
                        title: const Text(
                          "Multiple Day Event",
                          style: TextStyle(color: Colors.black87),
                        ),
                        value: 'Multiple Days',
                        groupValue: _eventDuration,
                        activeColor: Colors.deepOrange,
                        onChanged: (val) {
                          setState(() {
                            _eventDuration = val;
                            _selectedDate = null;
                            _startTimeController.clear();
                            _endTimeController.clear();
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),

                      // Date & Time Section
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _eventDuration == 'Multiple Days'
                            ? Column(
                                key: const ValueKey('multi'),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _startDateController,
                                    readOnly: true,
                                    onTap: _pickStartDate,
                                    decoration: InputDecoration(
                                      labelText: "Start Date",
                                      suffixIcon: const Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.deepOrange,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _endDateController,
                                    readOnly: true,
                                    onTap: _pickEndDate,
                                    decoration: InputDecoration(
                                      labelText: "End Date",
                                      suffixIcon: const Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.deepOrange,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _startTimeController,
                                    readOnly: true,
                                    onTap: _pickStartTime,
                                    decoration: InputDecoration(
                                      labelText: "Time From",
                                      suffixIcon: const Icon(
                                        Icons.access_time,
                                        color: Colors.deepOrange,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _endTimeController,
                                    readOnly: true,
                                    onTap: _pickEndTime,
                                    decoration: InputDecoration(
                                      labelText: "Time To",
                                      suffixIcon: const Icon(
                                        Icons.access_time,
                                        color: Colors.deepOrange,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : (_eventDuration == 'One Day'
                                  ? Column(
                                      key: const ValueKey('single'),
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        InkWell(
                                          onTap: _pickSingleDate,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade400,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  _selectedDate == null
                                                      ? "Select a date"
                                                      : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.deepOrange,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: _startTimeController,
                                          readOnly: true,
                                          onTap: _pickStartTime,
                                          decoration: InputDecoration(
                                            labelText: "Time From",
                                            suffixIcon: const Icon(
                                              Icons.access_time,
                                              color: Colors.deepOrange,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _endTimeController,
                                          readOnly: true,
                                          onTap: _pickEndTime,
                                          decoration: InputDecoration(
                                            labelText: "Time To",
                                            suffixIcon: const Icon(
                                              Icons.access_time,
                                              color: Colors.deepOrange,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink()),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        "Budget (USD)",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _budgetCtrl,
                        style: const TextStyle(color: Colors.black87),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your budget",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "Additional Requirements",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...[
                        {"label": "Catering", "value": _isCatering},
                        {"label": "Photography", "value": _isPhotography},
                        {"label": "Videography", "value": _isVideography},
                        {"label": "Stages", "value": _isStages},
                        {"label": "Hall", "value": _isHall},
                        {"label": "Farm", "value": _isFarm},
                      ].map((item) {
                        return CheckboxListTile(
                          title: Text(
                            item["label"] as String,
                            style: const TextStyle(color: Colors.black87),
                          ),
                          value: item["value"] as bool,
                          activeColor: Colors.deepOrange,
                          onChanged: (val) {
                            setState(() {
                              switch (item["label"]) {
                                case "Catering":
                                  _isCatering = val!;
                                  break;
                                case "Photography":
                                  _isPhotography = val!;
                                  break;
                                case "Videography":
                                  _isVideography = val!;
                                  break;
                                case "Stages":
                                  _isStages = val!;
                                  break;
                                case "Hall":
                                  _isHall = val!;
                                  break;
                                case "Farm":
                                  _isFarm = val!;
                                  break;
                              }
                            });
                          },
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        );
                      }),
                      const SizedBox(height: 16),

                      // Special Requirements
                      const Text(
                        "Special Requirements",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _specialReqCtrl,
                        style: const TextStyle(color: Colors.black87),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Describe any special requirements",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 🔸 Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Find Services",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.deepOrange),
                            ),
                          ),
                          child: const Text(
                            "Get AI Recommendations instead",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
