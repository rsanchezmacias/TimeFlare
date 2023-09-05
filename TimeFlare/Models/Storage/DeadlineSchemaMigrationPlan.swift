//
//  DeadlineMigrationPlan.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/31/23.
//

import SwiftData

enum DeadlineSchemaMigrationPlan: SchemaMigrationPlan {
    
    static var schemas: [any VersionedSchema.Type] {
        [DeadlineSchemaV1.self, DeadlineSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        return [migrationV1toV2]
    }
    
    static let migrationV1toV2 = MigrationStage.lightweight(fromVersion: DeadlineSchemaV1.self, toVersion: DeadlineSchemaV2.self)
    
}
