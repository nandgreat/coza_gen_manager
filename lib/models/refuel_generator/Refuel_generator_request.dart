class RefuelGeneratorRequest {
  RefuelGeneratorRequest({
    this.workerCode,
    this.confirmationWorkerCode,
    this.quantity,
    this.invoiceImageUrl,
    this.waybillImageUrl,
    this.dieselBeforeImageUrl,
    this.dieselAfterImageUrl,
  });

  RefuelGeneratorRequest.fromJson(dynamic json) {
    workerCode = json['worker_code'];
    confirmationWorkerCode = json['confirmation_worker_code'];
    quantity = json['quantity'];
    invoiceImageUrl = json['invoice_image_url'];
    waybillImageUrl = json['waybill_image_url'];
    dieselBeforeImageUrl = json['diesel_before_image_url'];
    dieselAfterImageUrl = json['diesel_after_image_url'];
  }

  String? workerCode;
  String? confirmationWorkerCode;
  int? quantity;
  String? invoiceImageUrl;
  String? waybillImageUrl;
  String? dieselBeforeImageUrl;
  String? dieselAfterImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['worker_code'] = workerCode;
    map['confirmation_worker_code'] = confirmationWorkerCode;
    map['quantity'] = quantity;
    map['invoice_image_url'] = invoiceImageUrl;
    map['waybill_image_url'] = waybillImageUrl;
    map['diesel_before_image_url'] = dieselBeforeImageUrl;
    map['diesel_after_image_url'] = dieselAfterImageUrl;
    return map;
  }
}
