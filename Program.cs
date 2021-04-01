using System;
using System.Threading.Tasks;
using BenchmarkDotNet.Running;

namespace BenchmarkSP
{
    class Program
    {
        static async Task Main(string[] args)
        {
            // SPBenchmarks sPBenchmarks = new SPBenchmarks();

            // await sPBenchmarks.FetchEmployeeDataSet();

            // await sPBenchmarks.FetchJSONResult();

            BenchmarkRunner.Run<SPBenchmarks>();
        }
    }
}
