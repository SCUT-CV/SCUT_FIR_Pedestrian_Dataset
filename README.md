# SCUT FIR Pedestrian Dataset
A new benchmark dataset and baseline for on-road FIR pedestrian detection

### Description
![example](dataset/example/example.png)
The SCUT FIR Pedestrian Datasets is a large far infrared pedestrian detection dataset. It  consist of about 11 hours-long image sequences ($\sim 10^6$ frames) at a rate of 25 Hz by driving through diverse traffic scenarios at a speed less than 80 km/h. The image sequences were collected from 11 road sections under 4 kinds of scenes including downtown, suburbs, expressway and campus in Guangzhou, China. We annotated 211,011 frames for a total number of 477,907 bounding boxes around 7,659 unique pedestrians.

### Download

videos [GoogleDrive](https://drive.google.com/open?id=0B5mvevJ3ivDKbXdkVlNNSGJDVGM) [BaiduYun](http://pan.baidu.com/s/1geBkEMf)

annotations [GoogleDrive]() [BaiduYun]() (will release after paper published)

### Tool

- `Seq video format`. Data Format is compatible with Caltech Pedestrian Dataset Format
- `datatool`.  Evaluation/labeling code for our dataset which is based on [Caltech Dataset](http://www.vision.caltech.edu/Image_Datasets/CaltechPedestrians/).
- `toolbox`. The `datatool` depended tool which is based on [Piotr's Matlab Toolbox](https://pdollar.github.io/toolbox/index.html).

### Baseline
- Thermal Faster R-CNN (TFRCN) in [xzhewei/TFRCN](https://github.com/xzhewei/TFRCN) released

### Benchmark Results

#### Algorithm List

|                      | Reasonable All | Overall |
| -------------------- | -------------- | ------- |
| RPN+BF               | 8.28           | 25.19   |
| TFRCN                | 9.98           | 32.32   |
| RPN (RPN+BF)         | 12.07          | 32.94   |
| Faster R-CNN-vanilla | 19.75          | 52.00   |
| RPN-vanilla          | 34.87          | 61.20   |
| ACF-T+THOG           | 43.70          | 62.11   |

Ther mertic is log-average miss rate over the range of [$10^{-2}$, $10^0$]. 

#### ROC

- [**Reasonable All**](dataset/benchmark/scuttestRocReasonable.pdf)
- [**Reasonable Walk Person**](dataset/benchmark/scuttestRocReasonable-walk-person.pdf)
- [**Reasonable Ride Person**](dataset/benchmark/scuttestRocReasonable-ride-person.pdf)
- [**Scale=Near**](dataset/benchmark/scuttestRocScale=near.pdf)
- [**Scale=Medium**](dataset/benchmark/scuttestRocScale=Medium.pdf)
- [**Scale=far**](dataset/benchmark/scuttestRocScale=far.pdf)
- [**No Occlusion**](dataset/benchmark/scuttestRocOcc=none.pdf)
- [**Occlusion**](dataset/benchmark/scuttestRocOcc=partial.pdf)
- [**Overall**](dataset/benchmark/scuttestRocAll.pdf)

### Contact

Please contact Zhewei Xu [xzhewei at gmail.com] with questions.
