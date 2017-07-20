/*
 * This file is part of MULTEM.
 * Copyright 2017 Ivan Lobato <Ivanlh20@gmail.com>
 *
 * MULTEM is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MULTEM is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MULTEM. If not, see <http:// www.gnu.org/licenses/>.
 */

#include "matlab_types.cuh"
#include "host_device_functions.cuh"

#include <mex.h>
#include "matlab_mex.cuh"

using mt::rmatrix_r;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	auto lx = mx_get_scalar<double>(prhs[0]);
    auto nx = mx_get_scalar<int>(prhs[1]);
	auto ly = (nrhs > 2)?mx_get_scalar<double>(prhs[2]):lx;
    auto ny = (nrhs > 3)?mx_get_scalar<int>(prhs[3]):nx;

    auto g_max = 0.5*min(nx/lx, ny/ly);

	/******************************************************************/
	auto rg_max = mx_create_scalar<rmatrix_r>(plhs[0]);

	rg_max[0] = g_max;
}