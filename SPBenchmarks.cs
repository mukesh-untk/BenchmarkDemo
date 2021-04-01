using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using BenchmarkDotNet.Attributes;
using Dapper;
using System.Text.Json;
using System.Collections.Generic;
using BenchmarkDotNet.Engines;

namespace BenchmarkSP
{
    [MemoryDiagnoser]
    [Orderer(BenchmarkDotNet.Order.SummaryOrderPolicy.FastestToSlowest)]
    [RankColumn]
    public class SPBenchmarks
    {
        private readonly SqlConnection con;

        public SPBenchmarks()
        {
            con = new SqlConnection("Server=DESKTOP-3COQ3VO;Database=Emp;User Id=sa;Password=cvbnm;MultipleActiveResultSets=true");
        }

        [Benchmark]
        public async Task FetchEmployeeDataSet()
        {
            var emps = await con.QueryAsync<Employee>("Admin.FetchEmployeeDataSet");
        }

        [Benchmark]
        public async Task FetchJSONResult()
        {
            var parameters = new DynamicParameters();
            parameters.Add("Result", dbType: DbType.String, direction: ParameterDirection.Output, size: int.MaxValue);
            
            await con.ExecuteAsync("Admin.FetchJSONResult", param: parameters, commandType: CommandType.StoredProcedure);
            var retVal = parameters.Get<string>("Result");
            var emps = JsonSerializer.Deserialize<IEnumerable<Employee>>(retVal);
        }
    }
}
