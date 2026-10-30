# DynamoDB & RDS - Database Services

AWS offers both managed relational databases and managed NoSQL databases. Choose based on data model, query patterns, consistency needs, operations, scale, and cost rather than assuming one service fits every workload.

## DynamoDB

### What it is

Amazon DynamoDB is a managed NoSQL database service. It supports key-value and document data models and is designed for predictable, low-latency access at scale. It does not provide the relational joins and SQL model of a traditional relational database.

### Core concepts

- **Tables:** Collections of items. A table has a primary key and can have secondary indexes for additional query patterns.
- **Items:** Individual records in a table.
- **Attributes:** Named values on an item. Items in a table do not need to have exactly the same non-key attributes.
- **Partition key:** Required primary-key component used to distribute and locate data. A good key distributes requests and data; a highly concentrated key can create a hot partition.
- **Sort key:** Optional second primary-key component. It allows multiple related items under a partition key and supports ordered/range queries within that key.
- **Access patterns:** Design the keys and indexes around the reads and writes the application needs. Queries generally require key conditions; avoid assuming arbitrary relational queries are available.

### Use cases

- Shopping carts, session state, and user preferences.
- High-throughput application metadata and event-driven workloads.
- Device, gaming, or catalog records with known key-based access patterns.

## Amazon RDS

### What it is

Amazon Relational Database Service (RDS) is a managed service for relational databases. AWS manages infrastructure tasks such as provisioning, backups, and supported maintenance options, while customers remain responsible for schema, query design, access controls, and application behavior.

### Core concepts

- **Supported engines:** Depending on feature and deployment choice, RDS supports Amazon Aurora and engines such as PostgreSQL, MySQL, MariaDB, Oracle Database, and Microsoft SQL Server. Engine availability, editions, and options vary by region.
- **DB instances:** Managed database compute and storage resources sized for a workload. RDS also offers Aurora clusters, whose architecture differs from standard RDS DB instances.
- **Security:** Place databases in private subnets, restrict security-group ingress to approved application sources, use IAM and database authentication appropriately, encrypt storage and backups, and protect secrets.
- **Backups:** Automated backups support point-in-time recovery within the configured retention period; manual snapshots can be retained. Verify retention and restoration procedures against recovery objectives.
- **Multi-AZ:** Provides a standby/failover arrangement for availability (implementation varies by engine and configuration). It is not primarily a read-scaling feature.
- **Read replicas:** Replicate data to offload eligible read traffic or support reporting/geographic patterns. Replication behavior and lag vary; read replicas are not a replacement for a tested backup/restore or high-availability strategy.

### Use cases

- Applications that need SQL, transactions, relational constraints, or existing engine compatibility.
- Content systems, enterprise applications, and transactional workloads.
- Workloads that need managed patching/backups and configurable availability options.

## Choosing between them

Prefer DynamoDB when access patterns are key-oriented and the application needs a managed NoSQL model with elastic scale. Prefer RDS when the workload needs relational structure, SQL, joins, or engine compatibility. Model and test with realistic access patterns, availability requirements, data size, and cost before selecting.
