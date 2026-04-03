# Kalman Filter Demo with Delphes Input Generation

This notebook demonstrates a simplified track reconstruction workflow inspired by high-energy physics experiments such as the ATLAS Collaboration at CERN.

Using simulated events generated with Delphes, we select truth-level muons from $\(Z \to \mu^+\mu^-\)$ decays and construct synthetic detector measurements. These measurements are then used to reconstruct the muon trajectory with a Kalman filter.

The goal is to illustrate how sequential state estimation can recover the underlying particle trajectory from noisy detector data.

This repository contains two Dockerized components:

- `zmm-delphes`: generates a simple `Z -> mu+ mu-` sample with Pythia8 and Delphes.
- `kalman-python`: starts a Jupyter Lab server with a Kalman filter notebook.

Both containers write their results to the shared `outputs/` directory at the repository root.

## Project Layout

```text
.
├── docker-compose.yml
├── kalman-python/
│   ├── Dockerfile
│   ├── extract_hits.ipynb
│   ├── hits_df.csv
│   └── kalman_filter.ipynb
├── zmm-delphes/
│   ├── Dockerfile
│   ├── run_zmm.sh
│   └── zmm.cmnd
└── outputs/
```

## Prerequisites

- Docker
- Docker Compose (`docker compose` command available)

## Build

Build both images:

```bash
docker compose build
```

Build only one service if needed:

```bash
docker compose build zmm-delphes
docker compose build kalman-python
```

Notes:

- The `zmm-delphes` image installs ROOT, Pythia8, build tools, and clones/builds Delphes `3.5.1`, so its first build can take a while.
- The `kalman-python` image installs `numpy`, `matplotlib`, `filterpy`, and Jupyter.

## Run

### 1. Generate the Delphes sample

```bash
docker compose run --rm zmm-delphes
```

This runs `zmm-delphes/run_zmm.sh`, which uses:

- Delphes card: `/opt/delphes/cards/delphes_card_ATLAS.tcl`
- Pythia command file: `zmm-delphes/zmm.cmnd`
- Output file: `outputs/zmm_delphes.root`

The current generator card is configured for:

- `10000` events
- `pp` collisions at `13 TeV`
- `Z/gamma* -> mu mu`
- invariant mass window `60-120 GeV`

### 2. Start the Jupyter notebook container

```bash
docker compose up kalman-python
```

Jupyter Lab will be available at:

```text
http://localhost:8888
```
or via VS Code by 

```bash
Dev Containers: Attach to Running Container...
```

The extract_hits.ipynb takes the Delphes output and extract hit information on a series of fake cylindrical plane simulating the different ATLAS Muon Stations. A csv file with the DataFrame is saved.  

## Run with Compose Defaults

Because both services already define commands in [`docker-compose.yml`](/Users/gregoriofalsetti/Desktop/Kalman_Filter/docker-compose.yml), you can also start them directly:

```bash
docker compose up zmm-delphes
docker compose up kalman-python
```

If you want both services available, launch them as separate commands. They are independent and do not orchestrate each other automatically.

## Outputs

After running the services, you should find:

- `outputs/zmm_delphes.root`

Create the directory manually if you want to inspect it ahead of time:

```bash
mkdir -p outputs
```

## Customization

### Change the Delphes generation settings

Edit [`zmm-delphes/zmm.cmnd`](/zmm-delphes/zmm.cmnd) to change:

- number of events,
- beam energy,
- random seed,
- process selection,
- phase-space cuts.

### Change the Kalman filter example

Edit [`kalman-python/kalman_filter.ipynb`](/kalman-python/kalman_filter.ipynb) to modify:

- the simulated trajectory,
- the measurement noise,
- the process noise model,
- the filter initialization.

## Clean Up

Remove stopped containers:

```bash
docker compose rm -f
```

Remove generated outputs:

```bash
rm -rf outputs/*
```
