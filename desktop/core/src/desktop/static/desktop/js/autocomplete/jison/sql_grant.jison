// Licensed to Cloudera, Inc. under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  Cloudera, Inc. licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

DataDefinition
 : GrantStatement
 | RevokeStatement
 ;

DataDefinition_EDIT
 : GrantStatement_EDIT
 | RevokeStatement_EDIT
 ;

GrantStatement
 : '<hive>GRANT' HivePrivilegeTypeList OptionalOnSpecification 'TO' PrincipalSpecificationList OptionalWithGrantOption
 | '<hive>GRANT' UserOrRoleList 'TO' PrincipalSpecificationList OptionalWithAdminOption
 | '<hive>GRANT' '<hive>ROLE' UserOrRoleList 'TO' PrincipalSpecificationList OptionalWithAdminOption
 | '<impala>GRANT' '<impala>ROLE' RegularOrBacktickedIdentifier 'TO' '<impala>GROUP' RegularOrBacktickedIdentifier
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' RegularOrBacktickedIdentifier OptionalWithGrantOption
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' '<impala>ROLE' RegularOrBacktickedIdentifier OptionalWithGrantOption
 ;

GrantStatement_EDIT
 : '<hive>GRANT' 'CURSOR'
   {
     suggestKeywords(['ALL', 'ALTER', 'CREATE', 'DELETE', 'DROP', 'INDEX', 'INSERT', 'LOCK', 'ROLE', 'SELECT', 'UPDATE']);
   }
 | '<hive>GRANT' HivePrivilegeTypeList_EDIT OptionalOnSpecification
 | '<hive>GRANT' HivePrivilegeTypeList OnSpecification_EDIT
 | '<hive>GRANT' HivePrivilegeTypeList OptionalOnSpecification 'CURSOR'
   {
     if (!$3) {
       suggestKeywords(['ON', 'TO']);
     } else {
       suggestKeywords(['TO']);
     }
   }
 | '<hive>GRANT' HivePrivilegeTypeList OptionalOnSpecification 'TO' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>GRANT' HivePrivilegeTypeList OptionalOnSpecification 'TO' PrincipalSpecificationList_EDIT
 | '<hive>GRANT' HivePrivilegeTypeList OptionalOnSpecification 'TO' PrincipalSpecificationList OptionalWithGrantOption 'CURSOR'
   {
     if (!$6) {
       suggestKeywords(['WITH GRANT OPTION']);
     }
   }
 | '<hive>GRANT' HivePrivilegeTypeList OptionalOnSpecification 'TO' PrincipalSpecificationList WithGrantOption_EDIT
 | '<hive>GRANT' UserOrRoleList 'CURSOR'
   {
     suggestKeywords(['TO']);
   }
 | '<hive>GRANT' UserOrRoleList 'TO' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>GRANT' UserOrRoleList 'TO' PrincipalSpecificationList_EDIT
 | '<hive>GRANT' UserOrRoleList 'TO' PrincipalSpecificationList OptionalWithAdminOption 'CURSOR'
   {
     if (!$5) {
       suggestKeywords(['WITH ADMIN OPTION']);
     }
   }
 | '<hive>GRANT' UserOrRoleList 'TO' PrincipalSpecificationList WithAdminOption_EDIT
 | '<hive>GRANT' '<hive>ROLE' UserOrRoleList 'TO' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>GRANT' '<hive>ROLE' UserOrRoleList 'TO' PrincipalSpecificationList_EDIT
 | '<hive>GRANT' '<hive>ROLE' UserOrRoleList 'TO' PrincipalSpecificationList OptionalWithAdminOption 'CURSOR'
   {
     if (!$6) {
       suggestKeywords(['WITH ADMIN OPTION']);
     }
   }
 | '<hive>GRANT' '<hive>ROLE' UserOrRoleList 'TO' PrincipalSpecificationList WithAdminOption_EDIT
 | '<impala>GRANT' 'CURSOR'
   {
     suggestKeywords(['ALL', 'INSERT', 'ROLE', 'SELECT']);
   }
 | '<impala>GRANT' '<impala>ROLE' RegularOrBacktickedIdentifier 'CURSOR'
   {
     suggestKeywords(['TO GROUP']);
   }
 | '<impala>GRANT' '<impala>ROLE' RegularOrBacktickedIdentifier 'TO' 'CURSOR'
   {
     suggestKeywords(['GROUP']);
   }
 | '<impala>GRANT' ImpalaPrivilegeType_EDIT
 | '<impala>GRANT' ImpalaPrivilegeType 'CURSOR'
   {
     suggestKeywords(['ON DATABASE', 'ON SERVER', 'ON TABLE', 'ON URI']);
   }
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' 'CURSOR'
   {
     suggestKeywords(['DATABASE', 'SERVER', 'TABLE', 'URI']);
   }
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification_EDIT
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'CURSOR'
   {
     suggestKeywords(['TO']);
   }
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' 'CURSOR'
   {
     suggestKeywords(['ROLE']);
   }
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' RegularOrBacktickedIdentifier OptionalWithGrantOption 'CURSOR'
   {
     if (!$7) {
       suggestKeywords(['WITH GRANT OPTION']);
     }
   }
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' RegularOrBacktickedIdentifier WithGrantOption_EDIT
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' '<impala>ROLE' RegularOrBacktickedIdentifier OptionalWithGrantOption 'CURSOR'
   {
     if (!$8) {
       suggestKeywords(['WITH GRANT OPTION']);
     }
   }
 | '<impala>GRANT' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'TO' '<impala>ROLE' RegularOrBacktickedIdentifier WithGrantOption_EDIT
 ;

OptionalOnSpecification
 :
 | 'ON' HiveObjectSpecification
 ;

OnSpecification_EDIT
 : 'ON' 'CURSOR'
   {
     suggestKeywords(['DATABASE', 'TABLE']);
     suggestTables();
     suggestDatabases({ appendDot: true });
   }
 | 'ON' HiveObjectSpecification_EDIT
 ;

HiveObjectSpecification
 : 'DATABASE' RegularOrBacktickedIdentifier
 | '<hive>TABLE' SchemaQualifiedTableIdentifier
   {
     addTablePrimary($2);
   }
 | SchemaQualifiedTableIdentifier
   {
     addTablePrimary($1);
   }
 ;

HiveObjectSpecification_EDIT
 : 'DATABASE' 'CURSOR'
   {
     suggestDatabases();
   }
 | '<hive>TABLE' 'CURSOR'
   {
     suggestTables();
     suggestDatabases({ appendDot: true });
   }
 | '<hive>TABLE' SchemaQualifiedTableIdentifier_EDIT
 | SchemaQualifiedTableIdentifier_EDIT
 ;

ImpalaObjectSpecification
 : 'DATABASE' RegularOrBacktickedIdentifier
 | '<impala>TABLE' SchemaQualifiedTableIdentifier
   {
     addTablePrimary($2);
   }
 | '<impala>SERVER' RegularOrBacktickedIdentifier
 | '<impala>URI' RegularOrBacktickedIdentifier
 ;

ImpalaObjectSpecification_EDIT
 : 'DATABASE' 'CURSOR'
   {
     suggestDatabases();
   }
 | '<impala>TABLE' 'CURSOR'
   {
     suggestTables();
     suggestDatabases({ appendDot: true });
   }
 | '<impala>TABLE' SchemaQualifiedTableIdentifier_EDIT
 ;

HivePrivilegeTypeList
 : HivePrivilegeTypeWithOptionalColumn
   {
     if ($1.toUpperCase() === 'ALL') {
       $$ = { singleAll: true };
     }
   }
 | HivePrivilegeTypeList ',' HivePrivilegeTypeWithOptionalColumn
 ;

HivePrivilegeTypeList_EDIT
 : HivePrivilegeTypeWithOptionalColumn_EDIT
 | HivePrivilegeTypeList ',' HivePrivilegeTypeWithOptionalColumn_EDIT
 | HivePrivilegeTypeWithOptionalColumn_EDIT ',' HivePrivilegeTypeList
 | HivePrivilegeTypeList ',' HivePrivilegeTypeWithOptionalColumn_EDIT ',' HivePrivilegeTypeList
 | 'CURSOR' ',' HivePrivilegeTypeList
   {
     suggestKeywords(['ALL', 'ALTER', 'CREATE', 'DELETE', 'DROP', 'INDEX', 'INSERT', 'LOCK', 'SELECT', 'SHOW_DATABASE', 'UPDATE']);
   }
 | HivePrivilegeTypeList ',' 'CURSOR'
   {
     suggestKeywords(['ALL', 'ALTER', 'CREATE', 'DELETE', 'DROP', 'INDEX', 'INSERT', 'LOCK', 'SELECT', 'SHOW_DATABASE', 'UPDATE']);
   }
 | HivePrivilegeTypeList ',' 'CURSOR' ',' HivePrivilegeTypeList
   {
     suggestKeywords(['ALL', 'ALTER', 'CREATE', 'DELETE', 'DROP', 'INDEX', 'INSERT', 'LOCK', 'SELECT', 'SHOW_DATABASE', 'UPDATE']);
   }
 ;

HivePrivilegeTypeWithOptionalColumn
 : HivePrivilegeType OptionalParenthesizedColumnList
 ;

HivePrivilegeTypeWithOptionalColumn_EDIT
 : HivePrivilegeType ParenthesizedColumnList_EDIT
 ;

HivePrivilegeType
 : '<hive>INSERT'
 | 'SELECT'
 | 'UPDATE'
 | '<hive>DELETE'
 | 'ALTER'
 | '<hive>CREATE'
 | 'DROP'
 | '<hive>INDEX'
 | '<hive>LOCK'
 | '<hive>SHOW_DATABASE'
 | '<hive>ALL'
 ;

ImpalaPrivilegeType
 : '<impala>INSERT'
 | 'SELECT' OptionalParenthesizedColumnList
 | 'ALL'
 ;

ImpalaPrivilegeType_EDIT
 : 'SELECT' ParenthesizedColumnList_EDIT
 ;

PrincipalSpecificationList
 : PrincipalSpecification
 | PrincipalSpecificationList ',' PrincipalSpecification
 ;

PrincipalSpecificationList_EDIT
 : PrincipalSpecificationList ',' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | 'CURSOR' ',' PrincipalSpecificationList
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | PrincipalSpecificationList ',' 'CURSOR' ',' PrincipalSpecificationList
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 ;

PrincipalSpecification
 : '<hive>USER' RegularOrBacktickedIdentifier
 | 'GROUP' RegularOrBacktickedIdentifier
 | '<hive>ROLE' RegularOrBacktickedIdentifier
 ;

UserOrRoleList
 : RegularOrBacktickedIdentifier
 | UserOrRoleList ',' RegularOrBacktickedIdentifier
 ;

OptionalWithGrantOption
 :
 | 'WITH' '<hive>GRANT' 'OPTION'
 | 'WITH' '<impala>GRANT' 'OPTION'
 ;

WithGrantOption_EDIT
 : 'WITH' 'CURSOR'
   {
     suggestKeywords(['GRANT OPTION']);
   }
 | 'WITH' '<hive>GRANT' 'CURSOR'
   {
     suggestKeywords(['OPTION']);
   }
 | 'WITH' '<impala>GRANT' 'CURSOR'
   {
     suggestKeywords(['OPTION']);
   }
 ;

OptionalWithAdminOption
 :
 | 'WITH' '<hive>ADMIN' 'OPTION'
 ;

WithAdminOption_EDIT
 : 'WITH' 'CURSOR'
   {
     suggestKeywords(['ADMIN OPTION']);
   }
 | 'WITH' '<hive>ADMIN' 'CURSOR'
   {
     suggestKeywords(['OPTION']);
   }
 ;

RevokeStatement
 : '<hive>REVOKE' HivePrivilegeTypeList OptionalOnSpecification 'FROM' PrincipalSpecificationList
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' HivePrivilegeTypeList OptionalOnSpecification 'FROM' PrincipalSpecificationList
 | '<hive>REVOKE' UserOrRoleList 'FROM' PrincipalSpecificationList
 | '<hive>REVOKE' '<hive>ROLE' UserOrRoleList 'FROM' PrincipalSpecificationList
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' UserOrRoleList 'FROM' PrincipalSpecificationList
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' '<hive>ROLE' UserOrRoleList 'FROM' PrincipalSpecificationList
 | '<hive>REVOKE' '<hive>ALL' PrivilegesOrGrantOption 'FROM' UserOrRoleList
 | '<impala>REVOKE' '<impala>ROLE' RegularOrBacktickedIdentifier 'FROM' '<impala>GROUP' RegularOrBacktickedIdentifier
 | '<impala>REVOKE' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'FROM' RegularOrBacktickedIdentifier
 | '<impala>REVOKE' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'FROM' '<impala>ROLE' RegularOrBacktickedIdentifier
 ;

RevokeStatement_EDIT
 : '<hive>REVOKE' 'CURSOR'
   {
     suggestKeywords(['ADMIN OPTION FOR', 'ALL', 'ALL GRANT OPTION FROM', 'ALL PRIVILEGES FROM', 'ALTER', 'CREATE', 'DELETE', 'DROP', 'GRANT OPTION FOR', 'INDEX', 'INSERT', 'LOCK', 'ROLE', 'SELECT', 'UPDATE']);
   }
 | '<hive>REVOKE' HivePrivilegeTypeList_EDIT
 | '<hive>REVOKE' HivePrivilegeTypeList OnSpecification_EDIT
 | '<hive>REVOKE' HivePrivilegeTypeList OptionalOnSpecification 'CURSOR'
   {
     if (!$3) {
       if ($2.singleAll) {
         suggestKeywords(['FROM', 'GRANT OPTION', 'ON', 'PRIVILEGES FROM']);
       } else {
         suggestKeywords(['FROM', 'ON']);
       }
     } else {
       suggestKeywords(['FROM']);
     }
   }
 | '<hive>REVOKE' HivePrivilegeTypeList OptionalOnSpecification 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>REVOKE' HivePrivilegeTypeList OptionalOnSpecification 'FROM' PrincipalSpecificationList_EDIT
 | '<hive>REVOKE' '<hive>GRANT' 'CURSOR'
   {
     suggestKeywords(['OPTION FOR']);
   }
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' 'CURSOR'
   {
     suggestKeywords(['FOR']);
   }
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' 'CURSOR'
   {
     suggestKeywords(['ALL', 'ALTER', 'CREATE', 'DELETE', 'DROP', 'INDEX', 'INSERT', 'LOCK', 'SELECT', 'SHOW_DATABASE', 'UPDATE']);
   }
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' HivePrivilegeTypeList_EDIT
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' HivePrivilegeTypeList OnSpecification_EDIT
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' HivePrivilegeTypeList OptionalOnSpecification 'CURSOR'
   {
     if (!$6) {
       suggestKeywords(['FROM', 'ON']);
     } else {
       suggestKeywords(['FROM']);
     }
   }
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' HivePrivilegeTypeList OptionalOnSpecification 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>REVOKE' '<hive>GRANT' 'OPTION' '<hive>FOR' HivePrivilegeTypeList OptionalOnSpecification 'FROM' PrincipalSpecificationList_EDIT
 | '<hive>REVOKE' UserOrRoleList 'CURSOR'
   {
     if ($2.toUpperCase() === 'ADMIN') {
       suggestKeywords(['FROM', 'OPTION FOR']);
     } else {
       suggestKeywords(['FROM']);
     }
   }
 | '<hive>REVOKE' UserOrRoleList 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>REVOKE' UserOrRoleList 'FROM' PrincipalSpecificationList_EDIT
 | '<hive>REVOKE' '<hive>ROLE' UserOrRoleList 'CURSOR'
   {
     suggestKeywords(['FROM']);
   }
 | '<hive>REVOKE' '<hive>ROLE' UserOrRoleList 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>REVOKE' '<hive>ROLE' UserOrRoleList 'FROM' PrincipalSpecificationList_EDIT

 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' 'CURSOR'
   {
     suggestKeywords(['FOR']);
   }
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' 'CURSOR'
   {
     suggestKeywords(['ROLE']);
   }
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' UserOrRoleList 'CURSOR'
   {
     suggestKeywords(['FROM']);
   }
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' UserOrRoleList 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' UserOrRoleList 'FROM' PrincipalSpecificationList_EDIT
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' '<hive>ROLE' UserOrRoleList 'CURSOR'
   {
     suggestKeywords(['FROM']);
   }
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' '<hive>ROLE' UserOrRoleList 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP', 'ROLE', 'USER']);
   }
 | '<hive>REVOKE' '<hive>ADMIN' 'OPTION' '<hive>FOR' '<hive>ROLE' UserOrRoleList 'FROM' PrincipalSpecificationList_EDIT
 | '<hive>REVOKE' '<hive>ALL' PrivilegesOrGrantOption_EDIT
 | '<hive>REVOKE' '<hive>ALL' PrivilegesOrGrantOption 'CURSOR'
   {
     suggestKeywords(['FROM']);
   }
 | '<impala>REVOKE' 'CURSOR'
   {
     suggestKeywords(['ALL', 'INSERT', 'ROLE', 'SELECT']);
   }
 | '<impala>REVOKE' '<impala>ROLE' RegularOrBacktickedIdentifier 'CURSOR'
   {
     suggestKeywords(['FROM GROUP']);
   }
 | '<impala>REVOKE' '<impala>ROLE' RegularOrBacktickedIdentifier 'FROM' 'CURSOR'
   {
     suggestKeywords(['GROUP']);
   }
 | '<impala>REVOKE' ImpalaPrivilegeType_EDIT
 | '<impala>REVOKE' ImpalaPrivilegeType 'CURSOR'
   {
     suggestKeywords(['ON DATABASE', 'ON SERVER', 'ON TABLE', 'ON URI']);
   }
 | '<impala>REVOKE' ImpalaPrivilegeType 'ON' 'CURSOR'
   {
     suggestKeywords(['DATABASE', 'SERVER', 'TABLE', 'URI']);
   }
 | '<impala>REVOKE' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification_EDIT
 | '<impala>REVOKE' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'CURSOR'
   {
     suggestKeywords(['FROM']);
   }
 | '<impala>REVOKE' ImpalaPrivilegeType 'ON' ImpalaObjectSpecification 'FROM' 'CURSOR'
   {
     suggestKeywords(['ROLE']);
   }
 ;

PrivilegesOrGrantOption
 : '<hive>PRIVILEGES'
 | '<hive>GRANT' 'OPTION'
 ;

PrivilegesOrGrantOption_EDIT
 : '<hive>GRANT' 'CURSOR'
   {
     suggestKeywords(['OPTION']);
   }
 ;