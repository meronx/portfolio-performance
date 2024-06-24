#!/bin/sh
cd /opt/portfolio/data
exec /opt/portfolio/PortfolioPerformance > /config/log/pp_out.log 2> /config/log/pp_err.log
