# SQL Server 2025 New Features

A comprehensive collection of demo scripts and resources showcasing the latest capabilities and improvements introduced in SQL Server 2025.

## 📋 Overview

SQL Server 2025 brings significant performance enhancements, new capabilities, and improved resource management. This repository contains hands-on demonstrations of 10 key new features that highlight the platform's evolution. Explore each feature through interactive scripts and learn how to leverage these improvements in your SQL Server environment.

## 🎯 Key Features Covered

1. **Time-Bound Extended Events** - Control event session duration with automatic cleanup
2. **Optimized Locking** - Improved lock performance and behavior
3. **Query Aborting** - Prevent problematic queries from executing
4. **Optimized sp_executesql** - Enhanced performance for parameterized queries
5. **TempDB ADR** - Accelerated Database Recovery for temporary databases
6. **TempDB Resource Governor** - Fine-grained tempdb resource allocation
7. **TempDB & TMPFS** - High-performance temporary database on Linux
8. **Backup Compression** - New ZSTD compression algorithm
9. **Backup Secondary Node** - Direct backups from availability group replicas
10. **External Endpoints** - Call external REST APIs from SQL Server

## 📁 Repository Structure

### Demos Directory

Interactive demonstration scripts organized by feature:

#### 1. Time-Bound Extended Events
- **`TimeBound_XEvents.sql`** - Create and manage time-limited event sessions that automatically stop after a specified duration

#### 2. Optimized Locking
- **`OptimisedLocking_QueryBehaviour1.sql`** - Demonstrate improved lock behavior and performance
- **`OptimisedLocking_QueryBehaviour2.sql`** - Compare locking patterns with new optimizations

#### 3. Aborting Queries
- **`AbortQueries.sql`** - Configure Query Store hints to prevent execution of problematic queries

#### 4. Optimized sp_executesql
- **`Optimized_sp_executesql.sql`** - Explore enhanced parameterized query performance
- **`osstress_runquery.bat`** - Stress testing script for performance validation

#### 5. TempDB ADR
- **`adr_run_query.sql`** - Execute queries demonstrating Accelerated Database Recovery
- **`adr_analyse_tempdb.sql`** - Analyze recovery performance metrics

#### 6. TempDB Resource Governor
- **`TempDB_ResourceGovernor.sql`** - Configure resource pools for tempdb space management
- **`reset_resource_governor.ps1`** - PowerShell utility to reset resource governor settings

#### 7. TempDB & TMPFS
- **`Run tempdb on tmpfs.ps1`** - Linux PowerShell automation for high-speed tempdb configuration

#### 8. Backup Compression
- **`BackupCompression.sql`** - Leverage new ZSTD compression algorithm for backups

#### 9. Backup Secondary Node
- **`BackupSecondaryNode.sql`** - Perform backups directly from availability group replicas

#### 10. External Endpoints
- **`external_rest_endpoints.sql`** - Invoke REST APIs and external services from T-SQL

### Additional Resources

- **`10 new features in SQL 2025.pdf`** - Comprehensive presentation slides covering all features

### Prerequisites
- SQL Server 2025 instance
- SQL Server Management Studio (SSMS) or Azure Data Studio
- For Linux demos: PowerShell Core installed

## 📚 Documentation & Resources

### Official Documentation

- [SQL Server 2025: What's New](https://learn.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-2025)
- [Optimized Locking](https://learn.microsoft.com/en-us/sql/relational-databases/performance/optimized-locking)
- [Query Store Hints - Aborting Queries](https://learn.microsoft.com/en-us/sql/relational-databases/performance/query-store-hints-best-practices?view=sql-server-ver17#block-future-execution-of-problematic-queries)
- [Optimized sp_executesql](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-executesql-transact-sql?view=sql-server-ver17&preserve-view=true#optimized_sp_executesql)
- [TempDB Resource Governor](https://learn.microsoft.com/en-us/sql/relational-databases/resource-governor/tempdb-space-resource-governance?view=sql-server-ver17)
- [Backup Compression - ZSTD Algorithm](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/backup-compression-sql-server?view=sql-server-ver17#zstd-compression-algorithm-introduced-in-sql-server-2025)
- [TempDB on TMPFS (Linux)](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-tmpfs-tempdb?view=sql-server-ver17)

### Learning Resources

- [Time-Bound Extended Events](https://learn.microsoft.com/en-us/sql/relational-databases/extended-events/sql-server-extended-events-sessions?view=sql-server-ver17#time-bound-event-sessions)
- [TMPFS File System Documentation](https://www.kernel.org/doc/html/latest/filesystems/tmpfs.html)
- [HammerDB Benchmark Scripts](https://github.com/nocentino/hammerdb)

### Related Blog Posts

- [Accessing the Kubernetes API from SQL Server 2025](https://dbafromthecold.com/2025/07/31/accessing-the-kubernetes-api-from-sql-server-2025)

## 📊 Presentation

This repository is designed to accompany a hands-on presentation on SQL Server 2025 new features. The included PDF provides detailed context for each feature demonstration.

## 🤝 Contributing

This repository welcomes contributions! If you have:

- Additional feature demonstrations
- Performance benchmarks or analysis
- Bug fixes or script improvements
- Documentation enhancements

Please submit a pull request with your changes.

## 📄 License

This project is provided as-is for educational and reference purposes.

## 👨‍💻 Author

**Andrew Pruski** (@dbafromthecold)
- Blog: [dbafromthecold.com](https://dbafromthecold.com)
- Email: dbafromthecold@gmail.com
- GitHub: [github.com/dbafromthecold](https://github.com/dbafromthecold)

---

*Built with ❤️ for the SQL Server community* 
