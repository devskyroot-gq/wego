class CarModel {
  final String id;
  final String brand;
  final String model;
  final String enrollment;
  final String? itv;
  final String owner;
  final String? insurance;

  const CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.enrollment,
    this.itv,
    required this.owner,
    this.insurance,
  });

  toJson() {
    return {
      "Brand": brand,
      "Model": model,
      "Enrollment": enrollment,
      "ITV": itv,
      "Owner": owner,
      "Insurance": insurance,
    };
  }

  //empty constructor
  factory CarModel.empty() => CarModel(
        id: "",
        brand: "",
        model: "",
        enrollment: "",
        itv: "",
        owner: "",
        insurance: "",
      );

  //setting data from firebase to the model
  factory CarModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return CarModel(
      id: documentId,
      brand: data["Brand"] ?? "",
      model: data["Model"] ?? "",
      enrollment: data["Enrollment"] ?? "",
      itv: data["ITV"] ?? "",
      owner: data["Owner"] ?? "",
      insurance: data["Insurance"] ?? "",
    );
  }
  
}



