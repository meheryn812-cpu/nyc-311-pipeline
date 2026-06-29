import logging
import subprocess
import sys
from pathlib import Path


LOG_FILE = Path("logs/run_pipeline.log")


def setup_logging():
    LOG_FILE.parent.mkdir(parents=True, exist_ok=True)

    logging.basicConfig(
        filename=LOG_FILE,
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
    )


def run_step(step_name, command):
    print(f"\nStarting step: {step_name}")
    logging.info("Starting step: %s", step_name)

    result = subprocess.run(command, shell=True)

    if result.returncode != 0:
        logging.error("Step failed: %s", step_name)
        print(f"Step failed: {step_name}")
        sys.exit(result.returncode)

    logging.info("Step completed successfully: %s", step_name)
    print(f"Step completed successfully: {step_name}")


def main():
    setup_logging()

    print("Starting NYC 311 ETL pipeline...")
    logging.info("Starting NYC 311 ETL pipeline.")

    run_step(
        "Extract NYC 311 API data",
        "python extract/extract_311_api.py"
    )

    run_step(
        "Clean API extract",
        "python extract/clean_api_extract.py"
    )

    run_step(
        "Load clean data to PostgreSQL",
        "python load/load_api_to_postgres.py"
    )

    print("\nPipeline completed successfully.")
    logging.info("Pipeline completed successfully.")


if __name__ == "__main__":
    main()