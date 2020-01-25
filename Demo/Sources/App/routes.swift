import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
    
    app.post("metrics") { request -> MetricsUploadResponse in
        let metrics = try request.content.decode(Welcome.self)
        let metricsData = try JSONEncoder().encode(metrics)
        try FileSystem().createFileIfNeeded(
            at: "~/Desktop/metrics/metrics.json",
            contents: metricsData
        )
        
        return MetricsUploadResponse(message: "Upload Success")
    }
    
    app.get("metrics") { request -> String in
        let metrics = try File(path: "~/Desktop/metrics/metrics.json").readAsString()
        return metrics
    }
}

struct MetricsUploadResponse: Content {
    let message: String
}


import Foundation

// MARK: - Welcome
struct Welcome: Content {
    let locationActivityMetrics: LocationActivityMetrics
    let cellularConditionMetrics: CellularConditionMetrics
    let metaData: MetaData
    let gpuMetrics: GPUMetrics
    let memoryMetrics: MemoryMetrics
    let signpostMetrics: [SignpostMetric]
    let displayMetrics: DisplayMetrics
    let cpuMetrics: CPUMetrics
    let networkTransferMetrics: NetworkTransferMetrics
    let diskIOMetrics: DiskIOMetrics
    let applicationLaunchMetrics: ApplicationLaunchMetrics
    let applicationTimeMetrics: ApplicationTimeMetrics
    let timeStampEnd: String
    let applicationResponsivenessMetrics: ApplicationResponsivenessMetrics
    let appVersion, timeStampBegin: String
}

// MARK: - ApplicationLaunchMetrics
struct ApplicationLaunchMetrics: Content {
    let histogrammedTimeToFirstDrawKey, histogrammedResumeTime: HistogrammedResumeTime
}

// MARK: - HistogrammedResumeTime
struct HistogrammedResumeTime: Content {
    let histogramNumBuckets: Int
    let histogramValue: [String: HistogramValue]
}

// MARK: - HistogramValue
struct HistogramValue: Content {
    let bucketCount: Int
    let bucketStart, bucketEnd: String
}

// MARK: - ApplicationResponsivenessMetrics
struct ApplicationResponsivenessMetrics: Content {
    let histogrammedAppHangTime: HistogrammedResumeTime
}

// MARK: - ApplicationTimeMetrics
struct ApplicationTimeMetrics: Content {
    let cumulativeForegroundTime, cumulativeBackgroundTime, cumulativeBackgroundAudioTime, cumulativeBackgroundLocationTime: String
}

// MARK: - CellularConditionMetrics
struct CellularConditionMetrics: Content {
    let cellConditionTime: HistogrammedResumeTime
}

// MARK: - CPUMetrics
struct CPUMetrics: Content {
    let cumulativeCPUTime: String
}

// MARK: - DiskIOMetrics
struct DiskIOMetrics: Content {
    let cumulativeLogicalWrites: String
}

// MARK: - DisplayMetrics
struct DisplayMetrics: Content {
    let averagePixelLuminance: Average
}

// MARK: - Average
struct Average: Content {
    let averageValue: String
    let standardDeviation, sampleCount: Int
}

// MARK: - GPUMetrics
struct GPUMetrics: Content {
    let cumulativeGPUTime: String
}

// MARK: - LocationActivityMetrics
struct LocationActivityMetrics: Content {
    let cumulativeBestAccuracyForNavigationTime, cumulativeBestAccuracyTime, cumulativeHundredMetersAccuracyTime, cumulativeNearestTenMetersAccuracyTime: String
    let cumulativeKilometerAccuracyTime, cumulativeThreeKilometersAccuracyTime: String
}

// MARK: - MemoryMetrics
struct MemoryMetrics: Content {
    let peakMemoryUsage: String
    let averageSuspendedMemory: Average
}

// MARK: - MetaData
struct MetaData: Content {
    let appBuildVersion, osVersion, regionFormat, deviceType: String
}

// MARK: - NetworkTransferMetrics
struct NetworkTransferMetrics: Content {
    let cumulativeCellularDownload, cumulativeWifiDownload, cumulativeCellularUpload, cumulativeWifiUpload: String
}

// MARK: - SignpostMetric
struct SignpostMetric: Content {
    let signpostIntervalData: SignpostIntervalData
    let signpostCategory, signpostName: String
    let totalSignpostCount: Int
}

// MARK: - SignpostIntervalData`
struct SignpostIntervalData: Content {
    let histogrammedSignpostDurations: HistogrammedResumeTime
    let signpostCumulativeCPUTime, signpostAverageMemory, signpostCumulativeLogicalWrites: String
}
