# Database Expert

> Mental model for database operations in this codebase.
> **Last Updated**: 2024-12-16
> **Expertise Level**: intermediate

## Quick Reference

### Key Files
| File | Purpose | When to Modify |
|------|---------|----------------|
| `src/db/connection.ts` | Database connection pool | Changing connection settings |
| `src/db/migrations/` | Schema migrations | Adding/modifying tables |
| `src/db/repositories/` | Data access layer | Adding queries |
| `src/db/types.ts` | TypeScript types for DB | Schema changes |

### Common Operations
| Operation | How To |
|-----------|--------|
| Add migration | `npm run db:migrate:create {name}` |
| Run migrations | `npm run db:migrate` |
| Add repository | Create file in `repositories/`, extend `BaseRepository` |
| Add query | Add method to relevant repository |

---

## Architecture Overview

This codebase uses a **repository pattern** with PostgreSQL. All database access goes through repository classes that extend `BaseRepository`.

### Component Map
```
┌─────────────┐     ┌──────────────┐     ┌────────────┐
│  Services   │ --> │ Repositories │ --> │  Database  │
└─────────────┘     └──────────────┘     └────────────┘
                           │
                    ┌──────┴──────┐
                    │ BaseRepository │
                    └─────────────┘
```

### Data Flow
1. Service calls repository method
2. Repository builds query using query builder
3. Query executed against connection pool
4. Results mapped to TypeScript types
5. Typed result returned to service

---

## Patterns & Conventions

### Pattern: Repository Method Naming
**Purpose**: Consistent, predictable method names
**When to Use**: Always when adding repository methods

```typescript
// Good - clear verb + noun pattern
async findUserById(id: string): Promise<User | null>
async findUsersByRole(role: Role): Promise<User[]>
async createUser(data: CreateUserInput): Promise<User>
async updateUser(id: string, data: UpdateUserInput): Promise<User>
async deleteUser(id: string): Promise<void>
```

**Anti-pattern** (don't do this):
```typescript
// Bad - unclear, inconsistent naming
async getUser(id: string)  // get vs find - pick one
async users(role: Role)    // missing verb
async addUser(data: any)   // add vs create - pick one
```

### Pattern: Transaction Handling
**Purpose**: Ensure atomic operations across multiple queries
**When to Use**: Any operation that modifies multiple tables

```typescript
async transferFunds(from: string, to: string, amount: number) {
  return this.withTransaction(async (trx) => {
    await this.debit(from, amount, trx);
    await this.credit(to, amount, trx);
    await this.recordTransfer({ from, to, amount }, trx);
  });
}
```

---

## File Locations

### Migrations
- `src/db/migrations/` - All schema migrations
  - Format: `{timestamp}_{description}.ts`
  - Each migration has `up()` and `down()` methods

### Repositories
- `src/db/repositories/` - Data access classes
  - `base.repository.ts` - Abstract base class
  - `user.repository.ts` - User table operations
  - `order.repository.ts` - Order table operations

### Types
- `src/db/types.ts` - All database-related TypeScript types
- Generated types go in `src/db/generated/` (don't edit manually)

---

## Gotchas & Edge Cases

### N+1 Query Problem
**Symptom**: Slow response times when fetching related data
**Cause**: Fetching parent records, then fetching children in a loop
**Solution**: Use eager loading with `withRelated()` method

```typescript
// Bad - N+1
const users = await userRepo.findAll();
for (const user of users) {
  user.orders = await orderRepo.findByUserId(user.id); // N queries!
}

// Good - single query with join
const users = await userRepo.findAll().withRelated('orders');
```

### Migration Ordering
**Symptom**: Migration fails with "relation does not exist"
**Cause**: Migrations run in timestamp order; dependency created after dependent
**Solution**: Always check migration timestamps when adding foreign keys

---

## Dependencies

### Internal
- `src/config/database.ts`: Provides connection configuration
- `src/utils/logger.ts`: Used for query logging in development

### External
- `pg`: PostgreSQL client
- `knex`: Query builder
- `pg-migrate`: Migration runner

---

## Testing

### How to Test
1. Tests use a separate test database (configured in `.env.test`)
2. Each test file can use `setupTestDb()` to get clean state
3. Use `factories/` to create test data

### Common Test Scenarios
- Repository CRUD: Test in isolation with test DB
- Transactions: Verify rollback on error
- Migrations: Test up and down separately

---

## Change Log

| Date | Change | Source |
|------|--------|--------|
| 2024-12-16 | Initial expertise file created | Setup task |
| 2024-12-15 | Added transaction pattern | User transfer feature |
| 2024-12-14 | Documented N+1 gotcha | Performance investigation |

---

## Open Questions

- [ ] Should we add read replicas for reporting queries?
- [ ] Evaluate connection pool size for production load
