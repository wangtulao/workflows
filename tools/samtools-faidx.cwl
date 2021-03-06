#!/usr/bin/env cwl-runner
#
# To use it as stand alone tool. The working directory should not have input .fa file
#    example: "./samtools-faidx.cwl --input=./test-files/mm10.fa"
# As part of a workflow should be no problem at all

cwlVersion: "cwl:draft-3"

class: CommandLineTool

requirements:
- $import: envvar-global.cwl
- $import: samtools-docker.cwl
- class: InlineJavascriptRequirement
- class: CreateFileRequirement
  fileDef:
  - filename: $(inputs.input.path.split('/').slice(-1)[0])
    fileContent: $(inputs.input)

inputs:
- id: '#input'
  type: File
  description: '<file.fa|file.fa.gz>'

- id: '#region'
  type: ["null",string]
  inputBinding:
    position: 2

outputs:
- id: "#index"
  type: File
  outputBinding:
    glob: $(inputs.input.path.split('/').slice(-1)[0]) #+'.fai')
  secondaryFiles:
  - .fai
  - .gzi

baseCommand:
- samtools
- faidx

arguments:
- valueFrom: $(inputs.input.path.split('/').slice(-1)[0])
  position: 1

description: |
  samtools-faidx.cwl is developed for CWL consortium
  Usage:   samtools faidx <file.fa|file.fa.gz> [<reg> [...]]

$namespaces:
  s: http://schema.org/

$schemas:
- https://sparql-test.commonwl.org/schema.rdf

s:mainEntity:
  $import: samtools-metadata.yaml

s:downloadUrl: https://github.com/common-workflow-language/workflows/blob/master/tools/samtools-faidx.cwl
s:codeRepository: https://github.com/common-workflow-language/workflows
s:license: http://www.apache.org/licenses/LICENSE-2.0

s:isPartOf:
  class: s:CreativeWork
  s:name: "Common Workflow Language"
  s:url: http://commonwl.org/

s:author:
  class: s:Person
  s:name: "Andrey Kartashov"
  s:email: mailto:Andrey.Kartashov@cchmc.org
  s:sameAs:
  - id: http://orcid.org/0000-0001-9102-5681
  s:worksFor:
  - class: s:Organization
    s:name: "Cincinnati Children's Hospital Medical Center"
    s:location: "3333 Burnet Ave, Cincinnati, OH 45229-3026"
    s:department:
    - class: s:Organization
      s:name: "Barski Lab"

