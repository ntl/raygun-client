{
  "occurredOn": string,
  "details": {
    "machineName": string,
    "version": string,
    "client": {
      "name": string,
      "version": string,
      "clientUrl": string
    },
    "error": {
      "innerError": string,
      "data": object,
      "className": string,
      "message": string,
      "stackTrace": [
      {
        "lineNumber": number,
        "className": string,
        "fileName": string,
        "methodName": string
      }]
    },
    "environment": {
      "processorCount": number,
      "osVersion": string ,
      "windowBoundsWidth": number,
      "windowBoundsHeight": number,
      "resolutionScale": string,
      "currentOrientation": string,
      "cpu": string,
      "packageVersion": string,
      "architecture": string,
      "totalPhysicalMemory": number,
      "availablePhysicalMemory": number,
      "totalVirtualMemory": number,
      "availableVirtualMemory": number,
      "diskSpaceFree": array,
      "deviceName": string,
      "locale": string
    },
    "tags": array,
    "userCustomData": object,
    "request": {
      "hostName": string,
      "url": string,
      "httpMethod": string,
      "iPAddress": string,
      "queryString": object,
      "form": object,
      "headers": object,
      "rawData": object
    },
    "response": {
      "statusCode": number
    },
    "user": {
      "identifier": string
    },
    "context": {
      "identifier": string
    }
  }
}
