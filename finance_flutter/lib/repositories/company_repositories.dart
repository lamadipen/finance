import 'package:finance_flutter/model/businessEntity/company.dart';

abstract class CompanyRepository {
  Future<void> addNewCompany(Company company);

  Future<void> deleteCompany(Company company);

  Stream<List<Company>> companies();

  Future<void> updateCompany(Company user);
}
